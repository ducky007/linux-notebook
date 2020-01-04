#!/bin/bash

# Remove old
rm hello.nes

# Build

./asm6 src/cart.asm hello.nes

# Run

nestopia hello.nes