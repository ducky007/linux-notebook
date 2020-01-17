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

screenPtr       .dsb 2
metaTile        .dsb 1
counter         .dsb 1
rowCounter      .dsb 1
softPPU_Control .dsb 1
softPPU_Mask    .dsb 1

    .ende

    .enum $0400 ; Variables at $0400. Can start on any RAM page

sleeping        .dsb 1

    .ende
;;;;;;;;;;;;;;;;;;;;;
;;;   CONSTANTS   ;;;
;;;;;;;;;;;;;;;;;;;;;

PRG_COUNT       = 1       ;1 = 16KB, 2 = 32KB
MIRRORING       = %0001

PPU_Control     .equ $2000
PPU_Mask        .equ $2001
PPU_Status      .equ $2002
PPU_Scroll      .equ $2005
PPU_Address     .equ $2006
PPU_Data        .equ $2007

spriteRAM       .equ $0200
    .org $C000
;;;;;;;;;;;;;;;;;
;;;   RESET   ;;;
;;;;;;;;;;;;;;;;;

RESET:
    sei
    cld
    lda #$40
    sta $4017
    ldx #$FF
    txs
    inx
    stx PPU_Control
    stx PPU_Mask
    stx $4010
    
vblank1:
    bit PPU_Status
    bpl vblank1

clrmem:
    lda #$00
    sta $0000,x
    sta $0100,x
    sta $0300,x
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    lda #$FE
    sta $0200,x
    inx
    bne clrmem

vblank2:
    bit PPU_Status
    bpl vblank2
    
    lda #<background
    sta screenPtr
    lda #>background
    sta screenPtr+1

    lda PPU_Status
    lda #$20
    sta PPU_Address
    lda #$00
    sta PPU_Address