# Bicycle Light
# Left: Change brightness
# Right: Change Blinking

import time
import board
import digitalio
import neopixel

pixels = neopixel.NeoPixel(board.NEOPIXEL, 10, brightness=0.1, auto_write=False)

led = digitalio.DigitalInOut(board.D13)
led.switch_to_output()

left_button = digitalio.DigitalInOut(board.BUTTON_A)
left_button.switch_to_input(pull=digitalio.Pull.DOWN)

right_button = digitalio.DigitalInOut(board.BUTTON_B)
right_button.switch_to_input(pull=digitalio.Pull.DOWN)

OFF = (0, 0, 0)
RED = (255, 0, 0)

left_down = False
right_down = False

frame = 0
brightness = 0.1
rate = 1

# light

def display(left, right):
    for i in range(5):
        pixels[i] = left
    for i in range(5):
        pixels[5 + i] = right

# clicks

def left_click():
    global brightness
    brightness = brightness + 0.2
    if brightness > 0.9:
        brightness = 0
    pixels.brightness = brightness
    print('brightness:', brightness)
    update()

def right_click():
    global rate
    rate = rate + 1
    if rate > 5:
        rate = 1
    print('rate:', rate)
    update()

# refresh

def update():
    global frame
    global rate
    if frame % rate is 0:
        display(RED, RED)
    else:
        display(OFF, OFF)
    pixels.show()

# main

while True:
    if left_button.value:
        led.value = True
        left_down = True
    elif right_button.value:
        led.value = True
        right_down = True
    else:
        led.value = False
        if left_down is True:
            left_click()
        if right_down is True:
            right_click()
        left_down = False
        right_down = False
    update()
    frame = frame + 1
    time.sleep(0.05)
