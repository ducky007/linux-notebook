include "src/head.asm"

metaBackground:
    lda #$00
    sta metaTile
    eor #$0F
    sta rowCounter
@top:
    lda #$10
    sta counter

    ldy metaTile
@loop:
    lda (screenPtr),y
    tax
    lda topLeft,x
    sta PPU_Data
    lda topRight,x
    sta PPU_Data
    iny
    dec counter
    bne @loop

    tya
    sec
    sbc #$10
    tay

    lda #$10
    sta counter
@loop2:
    lda (screenPtr),y
    tax
    lda bottomLeft,x
    sta PPU_Data
    lda bottomRight,x
    sta PPU_Data
    iny
    dec counter
    bne @loop2
    
    sty metaTile

    dec rowCounter
    bne @top

loadAttributes:
    ldx #$00
@loop:
    lda attributes,x
    sta PPU_Data
    inx
    cpx #$40
    bne @loop

    lda #<palette
    sta screenPtr
    lda #>palette
    sta screenPtr+1

loadPalettes:
    lda PPU_Status
    lda #$3F
    sta PPU_Address
    lda #$00
    sta PPU_Address

    ldy #$00
@loop:
    lda (screenPtr),y
    sta PPU_Data
    iny
    cpy #$20
    bne @loop
    
loadSprite:
    ldx #$00
    ldy #$00
@loop
    lda sprite_Y,x
    sta spriteRAM,y
    iny
    lda sprite_Tile,x
    sta spriteRAM,y
    iny
    lda sprite_Attrib,x
    sta spriteRAM,y
    iny
    lda sprite_X,x
    sta spriteRAM,y
    iny
    inx
    cpx #$10
    bne @loop


    lda #%10010000
    sta PPU_Control
    sta softPPU_Control
    lda #%00011110
    sta PPU_Mask
    sta softPPU_Mask

    jmp MAIN
    
;;;;;;;;;;;;;;;;;;;;;;;
;;;   SUBROUTINES   ;;;
;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;
;;;   MAIN   ;;;
;;;;;;;;;;;;;;;;

MAIN:
    inc sleeping
loop:
    lda sleeping
    bne loop

    jmp MAIN
MAINdone:

include "src/nmi.asm"

include "src/tables.asm"

;;;;;;;;;;;;;;;;;;;
;;;   VECTORS   ;;;
;;;;;;;;;;;;;;;;;;;

    .pad $FFFA

    .dw NMI
    .dw RESET
    .dw 0

;;;;;;;;;;;;;;;;;;;
;;;   CHR-ROM   ;;;
;;;;;;;;;;;;;;;;;;;

    .incbin "src/sprite.chr"
