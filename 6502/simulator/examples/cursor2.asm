;-------------------------------
; Zero Page
;-------------------------------
; $00 = Cursor X             (1)
; $01 = Cursor Y             (1)
; $02 = Cursor Flag          (1)
; $04 = Pointer              (2)
;-------------------------------  lda #0
  sta $00     ; Set Cursor X to 0
  sta $01     ; Set Cursor Y to 0 sta $04     ; Set Pointer LSB to $00
  lda #$02
  sta $05     ; Set Pointer MSB to $02;-------------------------------
; Main
;-------------------------------Main:
  jsr Control lda $02     ; Load Cursor Flag
  beq SkipCursorClear ; Check if cursor needs to be cleared
  lda #0      ; Set color to black
  ldy #0      ; Set offset to 0
  sta ($04), y    ; Write to Pointer
SkipCursorClear:  lda $01     ; Load Cursor Y
  lsr     ; Shift Right \
  lsr     ; Shift Right  = Divide by 8
  lsr     ; Shift Right /
  clc     ; Clear carry
  adc #$02    ; Add 2 to Pointer MSB
  sta $05     ; Set Pointer MSB lda $01     ; Load Cursor Y
  asl     ; Shift Left \
  asl     ; Shift Left  \
  asl     ; Shift Left   = Multiply by 32
  asl     ; Shift Left  /
  asl     ; Shift Left /
  clc     ; Clear carry
  adc $00     ; Add Cursor X to LSB
  sta $04     ; Set Pointer LSB lda #1      ; Set color to purple
  ldy #0      ; Set offset to 0
  sta ($04), y    ; Write to Pointer  jmp Main;-------------------------------
; Control
;-------------------------------Control:
  lda #1
  sta $02     ; Set Cursor Flag to TRUE lda $FF
  cmp #$64    ; Check if key is D
  beq CursorMoveRight
  cmp #$61    ; Check if key is A
  beq CursorMoveLeft
  cmp #$77    ; Check if key is W
  beq CursorMoveUp
  cmp #$73    ; Check if key is S
  beq CursorMoveDown  lda #0
  sta $02     ; Set Cursor Flag to FALSE
  rts;-------------------------------
; Cursor
;-------------------------------CursorMoveRight:
  lda #31
  cmp $00
  beq CursorSkipRight
  inc $00
CursorSkipRight:
  lda #0
  sta $FF
  rtsCursorMoveLeft:
  lda $00
  beq CursorSkipLeft
  dec $00
CursorSkipLeft:
  lda #0
  sta $FF
  rtsCursorMoveUp:
  lda $01
  beq CursorSkipUp
  dec $01
CursorSkipUp:
  lda #0
  sta $FF
  rtsCursorMoveDown:
  lda #31
  cmp $01
  beq CursorSkipDown
  inc $01
CursorSkipDown:
  lda #0
  sta $FF
  rts