#!/bin/bash

# Remove old
rm cart.nes

# Build

./asm6 src/cart.asm cart.nes

# Run

nestopia cart.nes