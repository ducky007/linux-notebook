LDA #1
STA $01     ; Zero Page

LDA #2
LDX #2
STA $00,X   ; Zero Page,X

LDA #3
STA $0003   ; Absolute

LDA #4
LDX #4
STA $0000,X ; Absolute,X

LDA #5
LDY #5
STA $0000,Y ; Absolute,Y