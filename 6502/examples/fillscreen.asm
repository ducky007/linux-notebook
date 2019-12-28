; Store $0200 at zero-page $00-$01
 
  lda #$00
  sta $00
  lda #$02
  sta $01
 
; Draw to screen
 
  lda #1       ; Set color to white
  ldy #0       ; Set memory offset to $00
Loop:
  sta ($00), y ; Write to ($00)+Y
  iny          ; Increment Y
  beq Next     ; Branch if Y is zero
  jmp Loop
Next:
  inc $01      ; Increment MSB of address in $00-$01
  jmp Loop