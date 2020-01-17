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
                        ; if compare was equal to 32, keep going down

; Set some initial ball stats

  LDA #$01
  STA balldown
  STA ballright
  LDA #$00
  STA ballup
  STA ballleft
  
  LDA #$50
  STA bally
  
  LDA #$80
  STA ballx
  
  LDA #$01
  STA ballspeedx
  STA ballspeedy

; Set starting game state

  LDA #STATEPLAYING
  STA gamestate
       
  LDA #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  STA $2000

  LDA #%00011110   ; enable sprites, enable background, no clipping on left side
  STA $2001

Forever:
  JMP Forever      ; jump back to Forever, infinite loop, waiting for NMI
  
NMI:
  LDA #$00
  STA $2003        ; set the low byte (00) of the RAM address
  LDA #$02
  STA $4014        ; set the high byte (02) of the RAM address, start the transfer

  JSR DrawScore

  ; This is the PPU clean up section, so rendering the next frame starts properly.

  LDA #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  STA $2000
  LDA #%00011110   ; enable sprites, enable background, no clipping on left side
  STA $2001
  LDA #$00         ; tell the ppu there is no background scrolling
  STA $2005
  STA $2005
  
GameEngine:  
  LDA gamestate
  CMP #STATETITLE
  BEQ EngineTitle      ; game is displaying title screen
    
  LDA gamestate
  CMP #STATEGAMEOVER
  BEQ EngineGameOver   ; game is displaying ending screen
  
  LDA gamestate
  CMP #STATEPLAYING
  BEQ EnginePlaying    ; game is playing
GameEngineDone:  
  JSR UpdateSprites    ; set ball/paddle sprites from positions
  RTI                  ; return from interrupt
 
;

EngineTitle:
  ; nothing
  JMP GameEngineDone

; 
 
EngineGameOver:
  ; nothing
  JMP GameEngineDone
 
; 
 
EnginePlaying:

MoveBallRight:
  LDA ballright
  BEQ MoveBallRightDone   ;;if ballright=0, skip this section

  LDA ballx
  CLC
  ADC ballspeedx        ;;ballx position = ballx + ballspeedx
  STA ballx

  LDA ballx
  CMP #RIGHTWALL
  BCC MoveBallRightDone      ;;if ball x < right wall, still on screen, skip next section
  LDA #$00
  STA ballright
  LDA #$01
  STA ballleft         ;;bounce, ball now moving left
  ;;in real game, give point to player 1, reset ball
MoveBallRightDone:


MoveBallLeft:
  LDA ballleft
  BEQ MoveBallLeftDone   ;;if ballleft=0, skip this section

  LDA ballx
  SEC
  SBC ballspeedx        ;;ballx position = ballx - ballspeedx
  STA ballx

  LDA ballx
  CMP #LEFTWALL
  BCS MoveBallLeftDone      ;;if ball x > left wall, still on screen, skip next section
  LDA #$01
  STA ballright
  LDA #$00
  STA ballleft         ;;bounce, ball now moving right
  ;;in real game, give point to player 2, reset ball
MoveBallLeftDone:


MoveBallUp:
  LDA ballup
  BEQ MoveBallUpDone   ;;if ballup=0, skip this section

  LDA bally
  SEC
  SBC ballspeedy        ;;bally position = bally - ballspeedy
  STA bally

  LDA bally
  CMP #TOPWALL
  BCS MoveBallUpDone      ;;if ball y > top wall, still on screen, skip next section
  LDA #$01
  STA balldown
  LDA #$00
  STA ballup         ;;bounce, ball now moving down
MoveBallUpDone:


MoveBallDown:
  LDA balldown
  BEQ MoveBallDownDone   ;;if ballup=0, skip this section

  LDA bally
  CLC
  ADC ballspeedy        ;;bally position = bally + ballspeedy
  STA bally

  LDA bally
  CMP #BOTTOMWALL
  BCC MoveBallDownDone      ;;if ball y < bottom wall, still on screen, skip next section
  LDA #$00
  STA balldown
  LDA #$01
  STA ballup         ;;bounce, ball now moving down
MoveBallDownDone:

  JMP GameEngineDone
 
; 

UpdateSprites:
  LDA bally  ; update all ball sprite info
  STA $0200
  LDA #$02   ; sprite tile
  STA $0201
  LDA #$00   ; 
  STA $0202
  LDA ballx
  STA $0203

  ; ball 2
  LDA bally  ; update all ball sprite info
  STA $0204
  LDA #$03   ; sprite tile
  STA $0205
  LDA #$00   ; palette
  STA $0206
  LDA ballx
  ADC #$08
  STA $0207

  ; ball 3
  LDA bally  ; update all ball sprite info
  STA $0208
  LDA #$04   ; sprite tile
  STA $0209
  LDA #$00   ; 
  STA $020a
  LDA ballx
  ADC #$10
  STA $020b

  ; ball 4
  LDA bally  ; update all ball sprite info
  STA $020c
  LDA #$05   ; sprite tile
  STA $020d
  LDA #$00   ; 
  STA $020e
  LDA ballx
  ADC #$18
  STA $020f

  ; row 2

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #08
  STA $0210
  LDA #$12   ; sprite tile
  STA $0211
  LDA #$00   ; 
  STA $0212
  LDA ballx
  STA $0213

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #08
  STA $0214
  LDA #$13   ; sprite tile
  STA $0215
  LDA #$00   ; 
  STA $0216
  LDA ballx
  ADC #$08
  STA $0217

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #08
  STA $0218
  LDA #$14   ; sprite tile
  STA $0219
  LDA #$00   ; 
  STA $021a
  LDA ballx
  ADC #$10
  STA $021b

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #08
  STA $021c
  LDA #$15   ; sprite tile
  STA $021d
  LDA #$00   ; 
  STA $021e
  LDA ballx
  ADC #$18
  STA $021f

  ; row 3

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #$10
  STA $0220
  LDA #$22   ; sprite tile
  STA $0221
  LDA #$00   ; 
  STA $0222
  LDA ballx
  STA $0223

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #$10
  STA $0224
  LDA #$23   ; sprite tile
  STA $0225
  LDA #$00   ; 
  STA $0226
  LDA ballx
  ADC #$08
  STA $0227

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #$10
  STA $0228
  LDA #$24   ; sprite tile
  STA $0229
  LDA #$00   ; 
  STA $022a
  LDA ballx
  ADC #$10
  STA $022b

  ; ball 4
  LDA bally  ; update all ball sprite info
  ADC #$10
  STA $022c
  LDA #$25   ; sprite tile
  STA $022d
  LDA #$00   ; 
  STA $022e
  LDA ballx
  ADC #$18
  STA $022f

  RTS
 
DrawScore:
  ; nothing
  RTS