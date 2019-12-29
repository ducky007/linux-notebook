#!/bin/bash

echo "Cleaning.."
rm example.nes
rm example.nes.dgb

ca65 example.s -g -o example.o
echo "ca65: done"

ld65 -o example.nes -C example.cfg example.o -m example.map.txt -Ln example.labels.txt --dbgfile example.nes.dbg
echo "ld65: done"

nestopia example.nes
echo "Running."
