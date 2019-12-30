#include <Adafruit_CircuitPlayground.h>

bool leftButtonPressed;
bool rightButtonPressed;
bool is_active = false;

int counter = 0;

void setup() {
  CircuitPlayground.begin();
}

void on_second(int counter) {
  CircuitPlayground.clearPixels();

  if(counter > 5400){
    CircuitPlayground.setPixelColor(0, 255,   0,   0);
  }
  if(counter > 4800){
    CircuitPlayground.setPixelColor(1, 255,   0,   0);
  }
  if(counter > 4200){
    CircuitPlayground.setPixelColor(2, 255,   0,   0);
  }
  if(counter > 3600){
    CircuitPlayground.setPixelColor(3, 255,   0,   0);
  }
  if(counter > 3000){
    CircuitPlayground.setPixelColor(4, 255,   0,   0);
  }
  if(counter > 2400){
    CircuitPlayground.setPixelColor(5, 255,   0,   0);
  }
  if(counter > 1800){
    CircuitPlayground.setPixelColor(6, 255,   0,   0);
  }
  if(counter > 1200){
    CircuitPlayground.setPixelColor(7, 255,   0,   0);
  }
  if(counter > 600){
    CircuitPlayground.setPixelColor(8, 255,   0,   0);
  }
  if(counter > 0){
    CircuitPlayground.setPixelColor(9, 255,   0,   0);
  }
}

void loop() {
  
  leftButtonPressed = CircuitPlayground.leftButton();
  rightButtonPressed = CircuitPlayground.rightButton();
  
  if(counter == 1 && is_active == true){
    CircuitPlayground.playTone(800, 1000);
    is_active = false;
  }

  if (leftButtonPressed) {
    is_active = true;
    counter = counter - 600;
    CircuitPlayground.playTone(700, 20);
    on_second(counter);
  } 
  if (rightButtonPressed) {
    is_active = true;
    counter = counter + 600; 
    CircuitPlayground.playTone(750, 20);
    on_second(counter);
  }
  
  if(counter % 10 == 0){
    on_second(counter);
  }
  
  counter = counter - 1;

  if(counter < 0){
    counter = 0;
  }
  if(counter > 6000){
    counter = 6000;
  }
  
  delay(100);
}
