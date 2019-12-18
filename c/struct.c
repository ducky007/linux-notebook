#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// cc -std=c99 -Wall struct.c -o struct -lm; ./struct

int count = 10;

int add_together(int x, int y) {
  int result = x + y;
  return result;
}

typedef struct {
  int x;
  int y;
  int z;
} point;

void print_point(point point) {
  printf("the point is: (%d,%d,%d)\n",point.x,point.y,point.z);
}

int main(int argc, char** argv) {

  point p;
  p.x = 2;
  p.y = 3;
  p.z = 4;

  float length = sqrt(p.x * p.x + p.y * p.y);

  printf("float: %.6f", length);
  printf("int: %d", p.z);

  print_point(p);

  return 0;
}