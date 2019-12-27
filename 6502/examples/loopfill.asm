ldx #$01     ;x is $01

loop: 
  lda $fe  
  sta $0200,x  ;store at memory location $a1
  inx          ;increment x
  jmp loop
