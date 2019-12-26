; Using X alone to index into the screen
; we just get 32x8 area to play in

LDX #$90  ; middle of the easy-to-reach area

plot:
STX $fc ; for debug
LDA #05
STA $0200,x
JMP waitforkey

waitforkey:
LDA $ff
BEQ waitforkey
STA $f8
LDA #0
STA $ff    ; clear the keypress for next time
STA $200,X ; clear the current pixel
LDA $f8

; WASD are $77 $61 $73 $64

CMP #$70
BCS updown

leftright:
CMP #$62
BCS right

left:
DEX        ; off the edge? who cares! 
JMP plot

right:
INX
JMP plot

updown:
CMP #$74
BCS up

down:
TXA
CLC
ADC #32
TAX
JMP plot

up:
TXA
SEC
SBC #32
TAX
JMP plot