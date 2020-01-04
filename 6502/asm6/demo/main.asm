;Include a header file which contains names for the hardware registers of the NES.
INCLUDE "nes.h"

;We declare variables by sticking them inside an "ENUM" block.  This example sets the symbol "ptr" to be at address $0000.
;The next symbol declared in here would be at the next address ($0002).
ENUM $0
ptr .dw 0
ENDE

;Declare some variables at Memory address $0300
ENUM $300
Vblanked .db 0
IrqJump .dw 0
NmiJump .dw 0
ENDE

OAM = $200
oambuffer = OAM

END_OF_RAM = $800

;32k bank - Bank 0
	.org $8000

Nmi:
	;Save the values of registers A, Y, and X onto the stack
	pha
	tya
	pha
	txa
	pha
	
	;NMI code goes here, we're not using any here.
	
	;Restore the values of registers X, Y, and A from the stack
	pla
	tax
	pla
	tay
	pla
	;Return from the interrupt
	rti

Main:
	;Disable NMI while we change the NMI jump address
	lda #$28		;8x16 spr, right obj, left bg, enable NMI, advance 1
	sta PPUCTRL
	lda #<Nmi
	sta NmiJump
	lda #>Nmi
	sta NmiJump+1
	;re-enable NMI
	lda #$A8		;8x16 spr, right obj, left bg, enable NMI, advance 1
	sta PPUCTRL
	
	;Turn off the screen so we can draw graphics
	lda #$00
	sta PPUMASK
	
	;Clear the nametable RAM
	jsr clear_nt
	
	;Write the palette
	;Writing to the PPU address always makes the high byte first.
	lda #>PPU_PALETTE
	sta PPUADDR
	lda #<PPU_PALETTE
	sta PPUADDR
	
	;Write the address of "Palette" into the variable "ptr".
	lda #<Palette
	sta ptr+0
	lda #>Palette
	sta ptr+1
	;We want to transfer 32 bytes
	ldx #32
	;Write them to VRAM
	jsr WriteVram
	
	;Set the PPU address to Row #2, column #2, which is address $2042
	lda #$20
	sta PPUADDR
	lda #32*2 + 2
	sta PPUADDR
	
	;Set "ptr" to the address of "HelloText"
	lda #<HelloText1
	sta ptr+0
	lda #>HelloText1
	sta ptr+1
	;Write this string to the PPU
	jsr WriteString
	
	;Wait a frame, so the display will be at the top for the first frame.
	jsr WaitFrame
	
	;Set scrolling and PPU address to 0 so the screen appears in the correct place.
	lda #0
	sta PPUSCROLL
	sta PPUSCROLL
	sta PPUADDR
	sta PPUADDR
	lda #$1E
	sta PPUMASK
	
	;We have nothing left to do, just do an endless loop.
EndlessLoop:
	jsr WaitFrame
	jmp EndlessLoop
	
	;Clear the Nametable memory on the PPU (PPU Address $2000-$23FF, and $2C00-$2FFF)
clear_nt:
	;Set PPU address to $2000
	lda #$20
	sta PPUADDR
	lda #$00
	sta PPUADDR
	;Clear the nametable
	jsr zero_nt
	;Set PPU address to $2C00
	lda #$2C
	sta PPUADDR
	lda #$00
	sta PPUADDR
zero_nt:
	lda #0	;zero byte
	ldy #0	;repeat 256 times
zero_nt_loop:
	;Write 4 zero bytes.  This will happen 4 times.
	sta $2007
	sta $2007
	sta $2007
	sta $2007
	;Repeat 256 times.
	dey
	;Loop back until counter reaches 0 after being decremented.
	bne zero_nt_loop
	;Return
	rts

;Write a small number of bytes to VRAM.
WriteVram:
	;X = number of bytes to write
	ldy #0
WriteVramLoop:
	;Load byte from PTR
	lda (ptr),y
	;Write to the PPU
	sta PPUDATA
	;Next byte
	iny
	;One less byte remaining
	dex
	;If we still have bytes left, loop.
	bne WriteVramLoop
	;return
	rts
	
;Writes a null-terminated string to VRAM
WriteString:
	ldy #0
writestring_loop:
	;Read the byte from ptr
	lda (ptr),y
	;If it's a zero byte, quit.
	beq writestring_quit
	;We are placing ASCII $20 at character number $00 in the graphics, so subtract $20.
	sec
	sbc #$20
	;Write to the PPU
	sta PPUDATA
	;Next byte
	iny
	;Loop (we used a BNE here to prevent a possible infinite loop if the string is longer than 256 bytes long)
	bne writestring_loop
writestring_quit:
	;Return
	rts


;Waits for the next frame.
WaitFrame:
WaitNMI:
	;Set the "Vblanked" variable to zero.  The NMI handler will increase this value when the PPU hits vblank.
	lda #0
	sta Vblanked

WaitNmiLoop:
	;Check if the other code has changed "Vblanked"
	lda Vblanked
	;If it hasn't, keep running.
	beq WaitNmiLoop
	;Return
	rts

;The text to display
HelloText1:
	.db "Josh DW Was Here!",0

;The palette to display.  $0F is black, $30 is white.
Palette:
	;Four palettes for the backgrounds
	.db $0F,$30,$30,$30
	.db $0F,$0F,$0F,$0F
	.db $0F,$0F,$0F,$0F
	.db $0F,$0F,$0F,$0F
	
	;Four palettes for the sprites (all black)
	.db $0F,$0F,$0F,$0F
	.db $0F,$0F,$0F,$0F
	.db $0F,$0F,$0F,$0F
	.db $0F,$0F,$0F,$0F
