ldx $0

loop:
  txa
  sta $0200,x
  sta $0300,x
  sta $0400,x
  sta $0500,x
  inx
  cpx #$20
  sta $0
  jmp loop