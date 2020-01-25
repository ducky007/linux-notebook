  ; Start at x=$20
  LDA #$20
  STA last_pos

LoadPalettes:
  LDA $2002    ; read PPU status to reset the high/low latch
  LDA #$3F
  STA $2006    ; write the high byte of $3F00 address
  LDA #$00
  STA $2006    ; write the low byte of $3F00 address
  LDX #$00
LoadPalettesLoop:
  LDA palette, x        ;load palette byte
  STA $2007             ;write to PPU
  INX                   ;set index to next byte
  CPX #$20            
  BNE LoadPalettesLoop  ;if x = $20, 32 bytes copied, all done

CreateSprite:
  LDX #$00
CreateSpriteLoop:
  LDA #$68
  STA $0200, x
  LDA last_pos
  STA $0201, x
  LDA #$00 
  STA $0202, x
  LDA last_pos
  STA $0203, x
  ; move 4 steps
  INX
  INX
  INX
  INX
  ; Move last_pos
  LDA last_pos
  ADC #$08
  STA last_pos
  ; loop 4 times
  CPX #$30            
  BNE CreateSpriteLoop

  LDA #%10000000   ; enable NMI, sprites from Pattern Table 0
  STA $2000
  LDA #%00010000   ; enable sprites
  STA $2001

Forever:
  JMP Forever     ;jump back to Forever, infinite loop

NMI:
  LDA #$00
  STA $2003  ; set the low byte (00) of the RAM address
  LDA #$02
  STA $4014  ; set the high byte (02) of the RAM address, start the transfer
  
  RTI        ; return from interrupt