; Zero Page
LDA #1
STA $01       

; Zero Page,X
LDA #2
LDX #2
STA $00,X   

; Absolute
LDA #3
STA $0003  

; Absolute,X
LDA #4
LDX #4
STA $0000,X 

; Absolute,Y
LDA #5
LDY #5
STA $0000,Y