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
  LDA verpos, x
  ADC sprite_id
  ADC sprite_id
  STA $0200, x ; pos y
  LDA #$06
  STA $0201, x ; sprite id
  LDA #$00 
  STA $0202, x ; param
  LDA horpos, x
  ADC sprite_id
  ADC sprite_id
  STA $0203, x ; pos x
  INC sprite_id
  INX ; move 4 steps
  INX
  INX
  INX
  CPX #$60 ; loop x times
  BNE CreateSpriteLoop

SetSpriteLayer1:
  LDX #$00
SetSpriteLayer1Loop:
  LDA #$02
  STA $0201, x ; pos x
  INX ; move 4 steps
  INX
  INX
  INX
  CPX #$20 ; loop x times
  BNE SetSpriteLayer1Loop

SetSpriteLayer2:
  LDX #$20
SetSpriteLayer2Loop:
  LDA #$04
  STA $0201, x ; pos x
  INX ; move 4 steps
  INX
  INX
  INX
  CPX #$40 ; loop x times
  BNE SetSpriteLayer2Loop

  LDA #%10000000   ; enable NMI, sprites from Pattern Table 0
  STA $2000
  LDA #%00010000   ; enable sprites
  STA $2001

Forever:
  JSR Update
  JMP Forever     ;jump back to Forever, infinite loop

NMI:
  LDA #$00
  STA $2003  ; set the low byte (00) of the RAM address
  LDA #$02
  STA $4014  ; set the high byte (02) of the RAM address, start the transfer
  
  RTI        ; return from interrupt

; layer 1

UpdateLayer1:
  INC frame_layer_1
  LDA frame_layer_1
  CMP #$ff
  BEQ UpdateLayer1End
  RTS
UpdateLayer1End:
  LDA #$00
  STA frame_layer_1
  JSR MoveLayer1
  JSR MoveLayersVert
  RTS

MoveLayer1:
  LDX #$00
MoveLayer1Loop:
  INC $0203, x ; pos x
  INX ; move 4 steps
  INX
  INX
  INX
  CPX #$20 ; loop x times
  BNE MoveLayer1Loop
  RTS

; layer 2

UpdateLayer2:
  INC frame_layer_2
  LDA frame_layer_2
  CMP #$d0
  BEQ UpdateLayer2End
  RTS
UpdateLayer2End:
  LDA #$00
  STA frame_layer_2
  JSR MoveLayer2
  RTS

MoveLayer2:
  LDX #$20
MoveLayer2Loop:
  INC $0203, x ; pos x
  INX ; move 4 steps
  INX
  INX
  INX
  CPX #$40 ; loop x times
  BNE MoveLayer2Loop
  RTS

; layer 3

UpdateLayer3:
  INC frame_layer_3
  LDA frame_layer_3
  CMP #$b0
  BEQ UpdateLayer3End
  RTS
UpdateLayer3End:
  LDA #$00
  STA frame_layer_3
  JSR MoveLayer3
  RTS

MoveLayer3:
  LDX #$40
MoveLayer3Loop:
  INC $0203, x ; pos x
  INX ; move 4 steps
  INX
  INX
  INX
  CPX #$60 ; loop x times
  BNE MoveLayer3Loop
  RTS

MoveLayersVert:
  LDX #$00
MoveLayersVertLoop:
  INC $0200, x ; pos x
  INX ; move 4 steps
  INX
  INX
  INX
  CPX #$60 ; loop x times
  BNE MoveLayersVertLoop
  RTS
  
Update:
  INC frame
  JSR UpdateLayer1
  JSR UpdateLayer2
  JSR UpdateLayer3
  RTS
