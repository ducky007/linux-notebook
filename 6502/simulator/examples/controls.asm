  LDA #$00
  STA $00
  LDA #$02
  STA $01
  LDA #0
  STA $02 ; pos x
  STA $03 ; pos y

main:
  JSR controls
  JSR locate
  JSR draw
  JMP main

controls:
  LDA $ff
  CMP #$77      ; w
  BEQ on_up
  CMP #$73      ; s
  BEQ on_down
  CMP #$61      ; a
  BEQ on_left
  CMP #$64      ; d
  BEQ on_right
  RTS

on_up:
  INC $03
  LDA #0
  STA $ff
  RTS

on_down:
  DEC $03
  LDA #0
  STA $ff
  RTS

on_right:
  INC $02
  LDA #0
  STA $ff
  RTS

on_left:
  DEC $02
  LDA #0
  STA $ff
  RTS

locate:
  LDA $02
  STA $04
  RTS

draw:
  LDA #1
  LDY $02
  STA ($00),y
  RTS