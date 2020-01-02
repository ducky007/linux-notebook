LDA #$00
STA $00
LDA #$02
STA $01
LDY #0

loop:
  LDA $fe
  STA ($00), y
  INY
  BEQ next
  JMP loop

reset:
  LDA #$00
  STA $01

next:
  INC $01
  LDX $01
  CPX #6
  BEQ reset
  JMP loop