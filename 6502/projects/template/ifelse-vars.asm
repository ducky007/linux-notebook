; defs
define _a $03
define _b $04

; memory
LDA #$11  
STA _a   
LDA #$11
STA _b

; logic
LDA _a
CMP _b
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