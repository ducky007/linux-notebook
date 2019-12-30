#include <stdio.h>
#include <stdlib.h>

// cc -std=c99 -Wall chapter3.c -o chapter3; ./chapter3

int count = 10;

int add_together(int x, int y) {
  int result = x + y;
  return result;
}

typedef struct {
  float x;
  float y;
} point;

int main(int argc, char** argv) {
  int x = add_together(2, 4);

  if (x > 10 && x < 100) {
    puts("x is greater than 10 and less than 100!");
  } else {
    puts("x is less than 11 or greater than 99!");
  }

  int i = 10;
  while (i > 0) {
    puts("WhileLoop Iteration");
    i = i - 1;
  }

  for (int i = 0; i < 10; i++) {
    puts("ForLoop Iteration");
  }

  return 0;
}
