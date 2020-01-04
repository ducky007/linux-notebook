LDX #$11  ; set X to 11
STX $03   ; save X to memory
LDY #$11  ; set Y to 11
STY $04   ; save Y to memory

CPX $04   ; compare with $04
BEQ when_equal
JSR when_unequal

when_equal:
  LDA #$5
  STA $0221
  JSR end

when_unequal:
  LDA #$2
  STA $0221
  JSR end

end:
  LDA #$1
  STA $0223
  BRK