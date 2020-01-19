; set health to 8

  LDA #$24
  STA health

; palette

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
  BNE LoadPalettesLoop  ; Branch to LoadPalettesLoop if compare was Not Equal to zero

; sprite

DrawSprite1:
  LDA #$0f
  STA $0200        ; set tile.y pos
  LDA #$01
  STA $0201        ; set tile.id
  LDA #$00
  STA $0202        ; set tile.attribute
  LDA #$08
  STA $0203        ; set tile.x pos

DrawSprite2:
  LDA #$0f
  STA $0204        ; set tile.y pos
  LDA #$02
  STA $0205        ; set tile.id
  LDA #$00
  STA $0206        ; set tile.attribute
  LDA #$10
  STA $0207        ; set tile.x pos

DrawSprite3:
  LDA #$0f
  STA $0208        ; set tile.y pos
  LDA #$03
  STA $0209        ; set tile.id
  LDA #$00
  STA $020a        ; set tile.attribute
  LDA #$16
  STA $020b        ; set tile.x pos

DrawHealth:
  LDA #$0f
  STA $0210        ; set tile.y pos
  LDA health
  STA $0211        ; set tile.id
  LDA #$00
  STA $0212        ; set tile.attribute
  LDA #$50
  STA $0213        ; set tile.x pos

; background

LoadBackground:
  LDA $2002             ; read PPU status to reset the high/low latch
  LDA #$20
  STA $2006             ; write the high byte of $2000 address
  LDA #$00
  STA $2006             ; write the low byte of $2000 address
  LDX #$00              ; start out at 0

; screen segment 1/4

LoadBackgroundLoop:
  LDA background, x     ; load data from address (background + the value in x)
  STA $2007             ; write to PPU
  INX                   ; X = X + 1
  CPX #$00              ; Each background table row is $10 in length
  BNE LoadBackgroundLoop  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero

  LDX #$00

EnableSprites:
  LDA #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  STA $2000
  LDA #%00011110   ; enable sprites, enable background, no clipping on left side
  STA $2001

Forever:
  JMP Forever     ;jump back to Forever, infinite loop

NMI:
  LDA #$00
  STA $2003       ; set the low byte (00) of the RAM address
  LDA #$02
  STA $4014       ; set the high byte (02) of the RAM address, start the transfer

  ;;This is the PPU clean up section, so rendering the next frame starts properly.

  LDA #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  STA $2000
  LDA #%00011110   ; enable sprites, enable background, no clipping on left side
  STA $2001
  LDA #$00        ;;tell the ppu there is no background scrolling
  STA $2005
  STA $2005

LatchController:
  LDA #$01
  STA $4016
  LDA #$00
  STA $4016       ; tell both the controllers to latch buttons

ReadA: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadADone
  LDA #$06        ; sprite tile
  STA $0201
ReadADone:        ; handling this button is done
  
ReadB: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadBDone
  LDA #$06        ; sprite tile
  STA $0201
ReadBDone:        ; handling this button is done

ReadSel: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadSelDone 
  LDA #$06        ; sprite tile
  STA $0201
ReadSelDone:        ; handling this button is done

ReadStart: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadStartDone 
  LDA #$06        ; sprite tile
  STA $0201
ReadStartDone:        ; handling this button is done

ReadUp: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadUpDone 
  JSR IncreaseHealth
  JSR UpdateHealth
  JSR UpdateBar
ReadUpDone:        ; handling this button is done

ReadDown: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadDownDone 
  JSR DecreaseHealth
  JSR UpdateHealth
  JSR UpdateBar
ReadDownDone:        ; handling this button is done

ReadLeft: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadLeftDone 
  DEC $0203
  LDA #$03        ; sprite tile
  STA $0201
ReadLeftDone:        ; handling this button is done

ReadRight: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadRightDone 
  INC $0203
  LDA #$04        ; sprite tile
  STA $0201
ReadRightDone:        ; handling this button is done
  
  RTI             ; return from interrupt

; Tools

IncreaseHealth:
  LDA health
  CMP #$29
  BCC DoIncrHealth
  RTS
DoIncrHealth:
  INC health
  RTS

DecreaseHealth:
  LDA health
  CMP #$21
  BCC DoDecrHealth
  DEC health
DoDecrHealth:
  RTS

; Draw subroutines

UpdateHealth:
  LDA health
  STA $0211        ; set tile.id
  RTS

UpdateBar:

  RTS