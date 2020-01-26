Start:
  LDA #$80
  STA cursor_pos_x
  STA cursor_pos_y
  LDA #$60
  STA ball_pos_x
  STA ball_pos_y

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
CreateBall:
  LDA #$88
  STA $0204        ; set tile.y pos
  LDA #$06
  STA $0205        ; set tile.id
  LDA #$00
  STA $0206        ; set tile.attribute
  LDA #$88
  STA $0207        ; set tile.x pos

CreateDebugX:
  LDA #$30
  STA $0208        ; set tile.y pos
  LDA #$05
  STA $0209        ; set tile.id
  LDA #$00
  STA $020a        ; set tile.attribute
  LDA #$20
  STA $020b        ; set tile.x pos
CreateDebugY:
  LDA #$30
  STA $020c        ; set tile.y pos
  LDA #$05
  STA $020d        ; set tile.id
  LDA #$00
  STA $020e        ; set tile.attribute
  LDA #$28
  STA $020f        ; set tile.x pos

  LDA #%10000000   ; enable NMI, sprites from Pattern Table 1
  STA $2000
  LDA #%00010000   ; enable sprites
  STA $2001

Forever:
  JSR Update
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
  NOP
ReadADone:        ; handling this button is done
  
ReadB: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadBDone
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
ReadUpDone:        ; handling this button is done

ReadDown: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadDownDone 
  INC cursor_pos_y
ReadDownDone:        ; handling this button is done

ReadLeft: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadLeftDone 
  DEC cursor_pos_x
ReadLeftDone:        ; handling this button is done

ReadRight: 
  LDA $4016
  AND #%00000001  ; only look at bit 0
  BEQ ReadRightDone 
  INC cursor_pos_x
ReadRightDone:        ; handling this button is done
  
  RTI             ; return from interrupt

; Set cursor sprite

SetCursorOn:
  LDA #$03
  STA $0201
  RTS

SetCursorOff:
  LDA #$04
  STA $0201
  RTS

TestX: ; check if x is between ball.x & ball.x + 8
  LDA cursor_pos_x
  SBC #$08
  CMP ball_pos_x
  BCC TestXPass
  JMP TestXFail
TestXPass:
  LDA cursor_pos_x
  CMP ball_pos_x
  BCC TestXFail
  JSR SetCursorOn
  RTS
TestXFail:
  JSR SetCursorOff
  RTS

Update:
  JSR TestX
UpdateDebug:
  LDA cursor_pos_x
  STA $0209
  LDA cursor_pos_y
  STA $020d
UpdateCursor:
  LDA cursor_pos_x
  STA cursor_sprite_x
  LDA cursor_pos_y
  STA cursor_sprite_y
UpdateBall:
  LDA ball_pos_x
  STA ball_sprite_x
  LDA ball_pos_y
  STA ball_sprite_y
  RTS