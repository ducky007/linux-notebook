;;;;;;;;;;;;;;;
;;;   NMI   ;;;
;;;;;;;;;;;;;;;

NMI:
    pha
    txa
    pha
    tya
    pha

    lda #$00
    sta $2003
    lda #$02
    sta $4014

    lda #$00
    sta PPU_Address
    sta PPU_Address

    lda #$00
    sta PPU_Scroll
    sta PPU_Scroll

    lda softPPU_Control
    sta PPU_Control
    lda softPPU_Mask
    sta PPU_Mask
    dec sleeping

    pla
    tay
    pla
    tax
    pla
    rti
NMIdone: