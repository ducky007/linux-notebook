; Store $0200 at zero-page $00-$01
  LDA #$00
  STA $00
  LDA #$02
  STA $01
; Draw to screen
  LDA #1       ; Set color to white
  LDY #0       ; Set memory offset to $00

Loop:
  STA ($00), y ; Write to ($00)+Y
  INY          ; Increment Y
  BEQ Next     ; Branch if Y is zero
  JMP Loop

Next:
  INC $01      ; Increment MSB of address in $00-$01
  JMP Loop