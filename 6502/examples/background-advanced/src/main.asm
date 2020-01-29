Start:
  LDA #$60
  STA cursor_pos_x
  STA cursor_pos_y
  LDA #$01
  STA brush

LoadPalettes:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$3F
  STA $2006             ; write the high byte of $3F00 address
  LDA #$00
  STA $2006             ; write the low byte of $3F00 address
  LDX #$00              ; start out at 0

LoadPalettesLoop:
  LDA palette, x        ; load data from address (palette + the value in x)
  STA $2007             ; write to PPU
  INX                   ; X = X + 1
  CPX #$20              ; Compare X to hex $10, decimal 16 - copying 16 bytes = 4 sprites
  BNE LoadPalettesLoop  

CreateCursor:
  LDA #$88
  STA $0200        ; set tile.y pos
  LDA #$04
  STA $0201        ; set tile.id
  LDA #$00
  STA $0202        ; set tile.attribute
  LDA #$88
  STA $0203        ; set tile.x pos

  LDA #$30
  STA $0204        ; set tile.y pos
  LDA brush
  STA $0205        ; set tile.id
  LDA #$00
  STA $0206        ; set tile.attribute
  LDA #$20
  STA $0207        ; set tile.x pos

  LDA #%10000000   ; enable NMI, sprites from Pattern Table 1
  STA $2000
  LDA #%00010000   ; enable sprites
  STA $2001

EnableSprites:
  LDA #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  STA $2000
  LDA #%00011110   ; enable sprites, enable background, no clipping on left side
  STA $2001

Forever:
  JSR Update

  LDA $2002
  LDA #$00         ; No background scrolling
  STA $2005
  STA $2005

  JMP Forever     ;jump back to Forever, infinite loop

NMI:
  LDA #$00
  STA $2003       ; set the low byte (00) of the RAM address
  LDA #$02
  STA $4014       ; set the high byte (02) of the RAM address, start the transfer

LatchController:
  LDA #$01
  STA $4016
  LDA #$00
  STA $4016       ; tell both the controllers to latch buttons

ReadA: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadADone
  JSR Paint
  NOP
ReadADone:        ; handling this button is done
  
ReadB: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadBDone
  JSR ChangeBrush
  NOP
ReadBDone:        ; handling this button is done

ReadSel: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadSelDone 
  NOP
ReadSelDone:        ; handling this button is done

ReadStart: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadStartDone 
  NOP
ReadStartDone:        ; handling this button is done

ReadUp: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadUpDone 
  DEC cursor_pos_y
  DEC cursor_pos_y
ReadUpDone:        ; handling this button is done

ReadDown: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadDownDone 
  INC cursor_pos_y
  INC cursor_pos_y
ReadDownDone:        ; handling this button is done

ReadLeft: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadLeftDone 
  DEC cursor_pos_x
  DEC cursor_pos_x
ReadLeftDone:        ; handling this button is done

ReadRight: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadRightDone 
  INC cursor_pos_x
  INC cursor_pos_x
ReadRightDone:        ; handling this button is done
  
  RTI             ; return from interrupt

; Set cursor sprite

Update:
UpdateCursor:
  LDA cursor_pos_x
  STA cursor_sprite_x
  LDA cursor_pos_y
  STA cursor_sprite_y
  RTS

Paint:
  LDA $2002
  LDA cursor_pos_y
  CLC
  ROL
  ROL
  PHA
  ROL
  AND #$03
  ORA #$20
  STA $2006
  PLA
  AND #$E0
  STA $40 ; Store value in zero-page
  LDA cursor_pos_x
  LSR
  LSR
  LSR
  CLC
  ADC $40 ; Use value in zero-page
  STA $2006
  LDA brush_id
  STA $2007
  RTS

ChangeBrush:
  INC brush
  LDA brush_id
  CMP #$10
  BNE ChangeBrushUpdate
  LDA #$00
  STA brush_id
ChangeBrushUpdate:
  LDA brush_id
  ADC #$10
  STA $0205
  LDA brush
  LSR
  LSR
  STA brush_id
  RTS