  JSR LoadBackground
  JSR LoadPalettes
  JSR LoadAttributes

EnableSprites:
  LDA #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  STA $2000
  LDA #%00011110   ; enable sprites, enable background, no clipping on left side
  STA $2001
  
  LDA #$00         ; No background scrolling
  STA $2006
  STA $2006
  STA $2005
  STA $2005

Forever:
  JMP Forever     ;jump back to Forever, infinite loop

LoadBackground:
; top

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$22
  STA $2006
  LDA #$02
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$23
  STA $2006
  LDA #$03
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$24
  STA $2006
  LDA #$03
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$25
  STA $2006
  LDA #$03
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$26
  STA $2006
  LDA #$03
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$27
  STA $2006
  LDA #$04
  STA $2007

  ; 

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$42
  STA $2006
  LDA #$08
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$47
  STA $2006
  LDA #$09
  STA $2007


  LDA $2002
  LDA #$21
  STA $2006
  LDA #$09
  STA $2006
  LDA #$0a
  STA $2007

  ;

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$62
  STA $2006
  LDA #$08
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$67
  STA $2006
  LDA #$09
  STA $2007

  ;

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$82
  STA $2006
  LDA #$05
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$83
  STA $2006
  LDA #$06
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$84
  STA $2006
  LDA #$06
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$85
  STA $2006
  LDA #$06
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$86
  STA $2006
  LDA #$06
  STA $2007

  LDA $2002
  LDA #$20
  STA $2006
  LDA #$87
  STA $2006
  LDA #$07
  STA $2007

  RTS

LoadPalettes:
  LDA $2002
  LDA #$3F
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
LoadPalettesLoop:
  LDA palettes, x
  STA $2007
  INX
  CPX #$20
  BNE LoadPalettesLoop
  RTS

LoadAttributes:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
LoadAttributesLoop:
  LDA attributes, x
  STA $2007
  INX
  CPX #$40
  BNE LoadAttributesLoop
  RTS

NMI:
  LDA #$00
  STA $2003       ; set the low byte (00) of the RAM address
  LDA #$02
  STA $4014       ; set the high byte (02) of the RAM address, start the transfer
  
  RTI             ; return from interrupt