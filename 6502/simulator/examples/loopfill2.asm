ldx $0
ldy $0

alt:
  iny
  jmp loop

loop:
  tya
  sta $0200,x
  sta $0300,x
  sta $0400,x
  sta $0500,x
  inx
  cpx #$0
  beq alt
  jmp loop