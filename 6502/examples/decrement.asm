LDX #$FF  
loop:
  DEX         ; X = X - 1
  BNE loop    ; if X not zero then goto loop
  RTS         ; return