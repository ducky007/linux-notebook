
loop:
  INC $00
  LDA $00
  CMP #$09
  BEQ on_10
  JMP loop

on_10:
  INX
  CPX #$09
  BEQ on_100
  LDA #0
  STA $00
  JMP loop

on_100:
  INY
  LDX #0
  JMP loop
  