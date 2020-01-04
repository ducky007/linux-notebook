;This file sort-of specifies a template to build a NES file.

;Here we specify a iNES header.
;First 4 bytes are "NES" followed by byte 1A.
;Next byte is the size of the PRG (in units of 16k pages)
;Next byte is the size of the CHR (in units of 8k pages)
;Next byte is the Mapper and flags byte, we are using Mapper #0 here, no battery-backed SRAM, and horizontal mirroring.
;Next byte is the Mapper high byte, zero here.
;Next 8 bytes are for "NES 2.0" files, keep them at zero here.

	.db "NES",$1A,2,1,0,0
	.db 0,0,0,0,0,0,0,0

;We set the program origin address to $8000 (which is the position in ROM that the program goes).
	.org $8000

;Include the Main code
include "main.asm"

;We advance to the end of the ROM area, to place the Boot code here.  We don't necessarily need to have the boot code here, but I like to put it near the end of the file.
	.org $FF50

;Include the Boot code
include "boot.asm"

;We advance to the very end of the ROM area, the three CPU vectors must go here.
	.org $FFFA

;Set the three CPU vectors:
;NMI (Non Maskable Interrupt) vector, this is the address to jump to when there's an interrupt from the PPU.
; This happens 60 times a second.
;Reset vector, the address the program starts
;IRQ (Interrupt Request) vector, the address to jump to when theres an interrupt that's not a NMI.
	.dw nmihandler, start, irqhandler

;Include the graphics for this ROM (the font)
incbin "hello.chr"
