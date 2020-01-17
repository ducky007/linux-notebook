;;;;;;;;;;;;;;;;;;;;;;;
;;;   iNES HEADER   ;;;
;;;;;;;;;;;;;;;;;;;;;;;

  .db  "NES", $1a     ;identification of the iNES header
  .db  PRG_COUNT      ;number of 16KB PRG-ROM pages
  .db  $01            ;number of 8KB CHR-ROM pages
  .db  $70|MIRRORING  ;mapper 7
  .dsb $09, $00       ;clear the remaining bytes

  .fillvalue $FF      ; Sets all unused space in rom to value $FF

;;;;;;;;;;;;;;;;;;;;;
;;;   VARIABLES   ;;;
;;;;;;;;;;;;;;;;;;;;;

  .enum $0000 ; Zero Page variables

gamestate     .dsb 1  ; .rs 1 means reserve one byte of space
ballx         .dsb 1  ; ball horizontal position
bally         .dsb 1  ; ball vertical position
ballup        .dsb 1  ; 1 = ball moving up
balldown      .dsb 1  ; 1 = ball moving down
ballleft      .dsb 1  ; 1 = ball moving left
ballright     .dsb 1  ; 1 = ball moving right
ballspeedx    .dsb 1  ; ball horizontal speed per frame
ballspeedy    .dsb 1  ; ball vertical speed per frame
paddle1ytop   .dsb 1  ; player 1 paddle top vertical position
paddle2ybot   .dsb 1  ; player 2 paddle bottom vertical position
buttons1      .dsb 1  ; player 1 gamepad buttons, one bit per button
buttons2      .dsb 1  ; player 2 gamepad buttons, one bit per button
score1        .dsb 1  ; player 1 score, 0-15
score2        .dsb 1  ; player 2 score, 0-15

  .ende

  .enum $0400 ; Variables at $0400. Can start on any RAM page

sleeping        .dsb 1

  .ende

;;;;;;;;;;;;;;;;;;;;;
;;;   CONSTANTS   ;;;
;;;;;;;;;;;;;;;;;;;;;

PRG_COUNT       = 1       ;1 = 16KB, 2 = 32KB
MIRRORING       = %0001

STATETITLE     = $00  ; displaying title screen
STATEPLAYING   = $01  ; move paddles/ball, check for collisions
STATEGAMEOVER  = $02  ; displaying game over screen
  
RIGHTWALL      = $D4  ; when ball reaches one of these, do something
TOPWALL        = $10
BOTTOMWALL     = $C4
LEFTWALL       = $08
  
PADDLE1X       = $08  ; horizontal position for paddles, doesnt move
PADDLE2X       = $F0

  .org $C000
  
;;;;;;;;;;;;;;;;;
;;;   RESET   ;;;
;;;;;;;;;;;;;;;;;

RESET:
  SEI          ; disable IRQs
  CLD          ; disable decimal mode
  LDX #$40
  STX $4017    ; disable APU frame IRQ
  LDX #$FF
  TXS          ; Set up stack
  INX          ; now X = 0
  STX $2000    ; disable NMI
  STX $2001    ; disable rendering
  STX $4010    ; disable DMC IRQs

vblankwait1:       ; First wait for vblank to make sure PPU is ready
  BIT $2002
  BPL vblankwait1

clrmem:
  LDA #$00
  STA $0000, x
  STA $0100, x
  STA $0300, x
  STA $0400, x
  STA $0500, x
  STA $0600, x
  STA $0700, x
  LDA #$FE
  STA $0200, x    ;move all sprites off screen
  INX
  BNE clrmem
   
vblankwait2:      ; Second wait for vblank, PPU is ready after this
  BIT $2002
  BPL vblankwait2