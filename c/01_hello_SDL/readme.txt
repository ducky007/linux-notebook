Copyright Notice:
-----------------
The files within this zip file are copyrighted by Lazy Foo' Productions (2004-2019)
and may not be redistributed without written permission.

This project is linked against:
----------------------------------------
Windows:
SDL2
SDL2main

*nix:
SDL2


cc -lSDL2main -lSDL2 -std=c99 -DDEBUG -Wall -Wpedantic -Wshadow -Wextra -Werror=implicit-int -Werror=incompatible-pointer-types -Werror=int-conversion -g -Og -fsanitize=address -fsanitize=undefined 01_hello.c -o 01_hello
