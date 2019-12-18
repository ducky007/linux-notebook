#!/usr/bin/env python

import logging
import socket
import time

from unicornhathd import set_pixel, brightness, show, clear

# Server

log = logging.getLogger('udp_server')

def udp_server(host='192.168.2.12', port=49161):
  s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  log.info("Listening on udp %s:%s" % (host, port))
  s.bind((host, port))
  while True:
    (data, addr) = s.recvfrom(128*1024)
    yield data

FORMAT_CONS = '%(asctime)s %(name)-12s %(levelname)8s\t%(message)s'
logging.basicConfig(level=logging.DEBUG, format=FORMAT_CONS)

# Setup

brightness(1.0)

# Utils

def full():
  x = 0
  while x < 16:
    y = 0
    while y < 16:
      set_pixel(x,y,255,255,255)
      y += 1
    x += 1

def line(y):
  x = 0
  while x < 16:
    set_pixel(x,y,255,255,255)
    x += 1

def note(id):
  x = 0
  while x < 16:
    y = 0
    while y < 16:
      if ((x + y) + (x * y)) % (id+1) == 0:
        set_pixel(x,y,255,0,0)
      y += 1
    x += 1

def dot(x,y):
  set_pixel(x,y,255,255,255)

def run(data):
  cmd = ''

  if data.find(':') < 0:
    parts = []
    cmd = data
  else:
    parts = data.split(':')
    cmd = parts[0]

  if data == 'show':
    show()
    time.sleep(.025)
    clear()
    show()
  elif data == 'clear':
    clear()
  elif cmd == 'f':
    full()
  elif cmd == 'l' and len(parts) > 0 and len(parts[1]) > 0:
    c = parts[1][0]
    line(ord(c) % 16)
  elif cmd == 'n' and len(parts) > 0 and len(parts[1]) > 0:
    c = parts[1][0]
    note(ord(c) % 16)
  elif cmd == 'd' and len(parts) > 0 and len(parts[1]) > 2:
    if parts[1].find(';') > -1:
      values = parts[1].split(';')
      dot(ord(values[0][0]) % 16,ord(values[1][0]) % 16)
  else:
    print(data)

# Listen

for data in udp_server():
  try:
    run(data)
  except IOError:
    print('error')
