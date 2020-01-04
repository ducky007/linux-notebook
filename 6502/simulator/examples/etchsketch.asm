
  LDA #$6F
  STA $40
  LDA #$03
  STA $41
  LDY #$00

loop1:
  LDA #$00
  STA $00FF
  LDX #$FF

loop:
  DEX
  BNE loop
  LDA $FF
  STA $0100
  LDA $0100
  CMP #$31
  BNE loop2
  JMP pointer

loop2:
  CMP #$32
  BNE loop3
  JMP pointer1

loop3:
  CMP #$33
  BNE loop4
  JMP pointer2

loop4:
  CMP #$34
  BNE loop5
  JMP pointer3

loop5:
  CMP #$35
  BNE loop30
  JMP pointer4

loop30:
  JMP loop1

pointer:
  LDA $40
  CMP #$00
  BNE loop10
  JMP loop1

loop10:
  CMP #$20
  BNE loop11
  JMP loop1

loop11:
  CMP #$40
  BNE loop12
  JMP loop1

loop12:
  CMP #$60
  BNE loop13
  JMP loop1

loop13:
  CMP #$80
  BNE loop14
  JMP loop1

loop14:
  CMP #$A0
  BNE loop15
  JMP loop1

loop15:
  CMP #$C0
  BNE loop16
  JMP loop1

loop16:
  CMP #$E0
  BNE loop17
  JMP loop1

loop17:
  DEC $40
  LDA #$0A
  STA ($40),y
  LDX #$FF

loop31:
  DEX
  BNE loop31
  LDA #$01
  STA ($40),y
  JMP loop1

pointer1:
  LDA $40
  CMP #$1F
  BNE loop18
  JMP loop1

loop18:
  CMP #$3F
  BNE loop19
  JMP loop1

loop19:
  CMP #$5F
  BNE loop20
  JMP loop1

loop20:
  CMP #$7F
  BNE loop21
  JMP loop1

loop21:
  CMP #$9F
  BNE loop22
  JMP loop1

loop22:
  CMP #$BF
  BNE loop23
  JMP loop1

loop23:
  CMP #$DF
  BNE loop24
  JMP loop1

loop24:
  CMP #$FF
  BNE loop25
  JMP loop1

loop25:
  INC $40
  LDA #$0A
  STA ($40),y
  LDX #$FF

loop32:
  DEX
  BNE loop32
  LDA #$01
  STA ($40),y
  JMP loop1

pointer2:
  LDX #$00
  STX $43
  LDA $40
  SEC
  SBC #$20
  STA $40
  LDA $41
  SBC #$00
  STA $41
  LDA $40
  CLC
  ADC #$20
  STA $40
  LDA $40
  SEC
  SBC #$20
  STA $40
  LDA #$0A
  STA ($40),y
  LDX #$FF

loop33:
  DEX
  BNE loop33
  LDA #$01
  STA ($40),y
  JMP loop1

pointer3:
  LDX $43
  CPX #$01
  BNE loop8
  JMP loop1

loop8:
  LDA $40
  CLC
  ADC #$20
  STA $40
  LDA $41
  ADC #$00
  CMP #$06
  STA $41
  BNE loop6
  LDX #$01
  STX $43
  JMP loop1

loop6:
  LDA #$0A
  STA ($40),y
  LDX #$FF

loop34:
  DEX
  BNE loop34
  LDA #$01
  STA ($40),y
  JMP loop1

pointer4:
  LDA #$00
  STA ($40),y
  JMP loop1