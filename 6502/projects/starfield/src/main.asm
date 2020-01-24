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

layer1:
  LDA #$20
  STA $0200        ; set tile.y pos
  LDA #$20
  STA $0201        ; set tile.id
  LDA #$00
  STA $0202        ; set tile.attribute
  LDA #$20
  STA $0203        ; set tile.x pos

layer2:
  LDA #$20
  STA $0204        ; set tile.y pos
  LDA #$20
  STA $0205        ; set tile.id
  LDA #$00
  STA $0206        ; set tile.attribute
  LDA #$28
  STA $0207        ; set tile.x pos

layer3:
  LDA #$20
  STA $0208        ; set tile.y pos
  LDA #$20
  STA $0209        ; set tile.id
  LDA #$00
  STA $020a        ; set tile.attribute
  LDA #$30
  STA $020b        ; set tile.x pos

star1:
  LDA #$40
  STA $020c        ; set tile.y pos
  LDA #$02
  STA $020d        ; set tile.id
  LDA #$00
  STA $020e        ; set tile.attribute
  LDA #$30
  STA $020f        ; set tile.x pos

star2:
  LDA #$48
  STA $0210        ; set tile.y pos
  LDA #$03
  STA $0211        ; set tile.id
  LDA #$00
  STA $0212        ; set tile.attribute
  LDA #$30
  STA $0213        ; set tile.x pos

star3:
  LDA #$50
  STA $0214        ; set tile.y pos
  LDA #$04
  STA $0215        ; set tile.id
  LDA #$00
  STA $0216        ; set tile.attribute
  LDA #$30
  STA $0217        ; set tile.x pos

star4:
  LDA #$58
  STA $0218        ; set tile.y pos
  LDA #$04
  STA $0219        ; set tile.id
  LDA #$00
  STA $021a        ; set tile.attribute
  LDA #$30
  STA $021b        ; set tile.x pos

star5:
  LDA #$60
  STA $021c        ; set tile.y pos
  LDA #$05
  STA $021d        ; set tile.id
  LDA #$00
  STA $021e        ; set tile.attribute
  LDA #$30
  STA $021f        ; set tile.x pos

star6:
  LDA #$68
  STA $0220        ; set tile.y pos
  LDA #$06
  STA $0221        ; set tile.id
  LDA #$00
  STA $0222        ; set tile.attribute
  LDA #$30
  STA $0223        ; set tile.x pos

star7:
  LDA #$70
  STA $0224        ; set tile.y pos
  LDA #$07
  STA $0225        ; set tile.id
  LDA #$00
  STA $0226        ; set tile.attribute
  LDA #$30
  STA $0227        ; set tile.x pos

star8:
  LDA #$78
  STA $0228        ; set tile.y pos
  LDA #$08
  STA $0229        ; set tile.id
  LDA #$00
  STA $022a        ; set tile.attribute
  LDA #$30
  STA $022b        ; set tile.x pos

star9:
  LDA #$80
  STA $022c        ; set tile.y pos
  LDA #$09
  STA $022d        ; set tile.id
  LDA #$00
  STA $022e        ; set tile.attribute
  LDA #$30
  STA $022f        ; set tile.x pos

; Randomize positions
SetHorPos:
  LDA #$00
  STA $020f
  LDA #$12
  STA $0213
  LDA #$ef
  STA $0217
  LDA #$cb
  STA $021b
  LDA #$7d
  STA $021f
  LDA #$3b
  STA $0223
  LDA #$4c
  STA $0227
  LDA #$2d
  STA $022b
  LDA #$dd
  STA $022f
SetVerPos:
  LDA #$00
  STA $020c
  LDA #$12
  STA $0210
  LDA #$ef
  STA $0214
  LDA #$cb
  STA $0218
  LDA #$7d
  STA $021c
  LDA #$3b
  STA $0220
  LDA #$4c
  STA $0224
  LDA #$2d
  STA $0228
  LDA #$dd
  STA $022c

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

UpdateLayerY:
  INC frame_layer_y
  LDA frame_layer_y
  CMP #$ff
  BEQ UpdateLayerYEnd
  RTS
UpdateLayerYEnd:
  LDA #$00
  STA frame_layer_y
  INC $020c
  INC $0210
  INC $0214
  INC $0218
  INC $021c
  INC $0220
  INC $0224
  INC $0228
  INC $022c
  RTS

UpdateLayer1:
  INC frame_layer_1
  LDA frame_layer_1
  CMP #$c0
  BEQ UpdateLayer1End
  RTS
UpdateLayer1End:
  LDA #$00
  STA frame_layer_1
  INC $020f ; Update Start 1
  INC $0213 ; Update Start 2
  INC $0217 ; Update Start 3
  RTS

UpdateLayer2:
  INC frame_layer_2
  LDA frame_layer_2
  CMP #$a0
  BEQ UpdateLayer2End
  RTS
UpdateLayer2End:
  LDA #$00
  STA frame_layer_2
  INC $021b
  INC $021f
  INC $0223
  RTS

UpdateLayer3:
  INC frame_layer_3
  LDA frame_layer_3
  CMP #$80
  BEQ UpdateLayer3End
  RTS
UpdateLayer3End:
  LDA #$00
  STA frame_layer_3
  INC $0227
  INC $022b
  INC $022f
  RTS

UpdateLayers:
  INC frame
  JSR UpdateLayer1
  JSR UpdateLayer2
  JSR UpdateLayer3
  JSR UpdateLayerY
  RTS

UpdateGui:
  LDA frame_layer_1
  ADC #$20
  STA $0201

  LDA frame_layer_2
  ADC #$20
  STA $0205

  LDA frame_layer_3
  ADC #$20
  STA $0209
  RTS

Update:
  JSR UpdateLayers
  JSR UpdateGui

  RTS