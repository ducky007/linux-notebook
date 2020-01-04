loop: 
  LDA $fe       ; A=rnd
  STA $00       ; ZP(0)=A
  LDA $fe
  AND #$3       ; A=A&3
  CLC           ; Clear carry
  ADC #$2       ; A+=2
  STA $01       ; ZP(1)=A
  LDA $fe       ; A=rnd
  LDY #$0       ; Y=0
  STA ($00),y   ; ZP(0),ZP(1)=y
  JMP loop