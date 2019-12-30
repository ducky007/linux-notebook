#!/usr/bin/env python

import logging
import socket
import time
import os

from unicornhat import set_pixel, show, clear, set_layout, rotation, brightness

# Server

mine = os.popen('ifconfig usb0 | grep "inet 192" | cut -c 14-25')
ip = mine.read()

log = logging.getLogger('udp_server')

def udp_server(host, port=49160):
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

def full(r=255,g=255,b=255):
  x = 0
  while x < 4:
    y = 0
    while y < 8:
      set_pixel(x,y,r,g,b)
      y += 1
    x += 1

def circle(r=255,g=255,b=255):
  y = 0
  set_pixel(1,0,r,g,b)
  set_pixel(2,0,r,g,b)
  set_pixel(1,7,r,g,b)
  set_pixel(2,7,r,g,b)
  while y < 8:
    set_pixel(0,y,r,g,b)
    set_pixel(3,y,r,g,b)
    y += 1

def edge(r=255,g=255,b=255):
  set_pixel(0,0,r,g,b)
  set_pixel(0,7,r,g,b)
  set_pixel(3,0,r,g,b)
  set_pixel(3,7,r,g,b)

def line(id,r=255,g=255,b=255):
  y = id % 4
  set_pixel(y,0,r,g,b)
  set_pixel(y,1,r,g,b)
  set_pixel(y,2,r,g,b)
  set_pixel(y,3,r,g,b)
  set_pixel(y,4,r,g,b)
  set_pixel(y,5,r,g,b)
  set_pixel(y,6,r,g,b)
  set_pixel(y,7,r,g,b)

def note(id,r=255,g=255,b=255):
  circle(255,0,0)

def rand(id,r=255,g=255,b=255):
  set_pixel(id % 4,id % 8,r,g,b)

def appear():
  show()
  time.sleep(.025)
  clear()
  show()

def run(data):
  cmd = ''
  # Parse
  if data.find(':') < 0:
    parts = []
    cmd = data
  else:
    parts = data.split(':')
    cmd = parts[0]
  # Defaults
  if data == 'show':
    appear()
    return
  elif data == 'clear':
    clear()
    return
  # Commands
  if cmd == 'f':
    full()
  elif cmd == 'c':
    circle()
  elif cmd == 'e':
    edge()
  elif cmd == 'l' and len(parts) > 0:
    line(int(parts[1]))
  elif cmd == 'n' and len(parts) > 0 and len(parts[1]) > 0:
    note(int(parts[1]))
  elif cmd == 'r' and len(parts) > 0 and len(parts[1]) > 0:
    rand(int(parts[1]))
  else:
    print(data)

# Listen

for data in udp_server(ip):
  try:
    run(data)
  except IOError:
    print('error')
