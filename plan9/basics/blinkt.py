#!/usr/bin/env python

import logging
import socket
import time

from blinkt import set_pixel, set_brightness, show, clear

# Server

log = logging.getLogger('udp_server')

def udp_server(host='192.168.2.9', port=49160):
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

set_brightness(1.0)

# Utils

def parse(data):

  # Clear
  if len(data) < 4:
    clear()
    show()
    return

  # Write
  ch = data[2]
  id = int(data[1])
  # val = int(ch)

  if id > 7:
    return
  if ch == "w":
    set_pixel(id, 255, 255, 255)
  if ch == "r":
    set_pixel(id,255,0,0)
  if ch == "g":
    set_pixel(id,0,255,0)
  if ch == "b":
    set_pixel(id,0,0,255)
  show()

# Listen

for data in udp_server():
  parse("%r" % (data,))