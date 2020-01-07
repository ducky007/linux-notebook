; This file specifies a template to build a NES file.
; The iNES header.

	.db "NES",$1A,2,1,0,0
	.db 0,0,0,0,0,0,0,0

; We set the program origin address.

	.org $8000           

; Include names for the hardware registers.

include "src/hardware.asm"

; Include the Main code.

include "src/main.asm"

; We advance to the end of the ROM area, to place the Boot code here.

	.org $FF50

; Include the Boot code.

include "src/boot.asm"

; We advance to the very end of the ROM area, set the three CPU vector.

	.org $FFFA

; nmihandler, the address to jump to when there's an interrupt from the PPU.
; start, the address the program starts.
; irqhandler, the address to jump to when theres an interrupt that's not a NMI.

	.dw nmihandler, start, irqhandler

; Include the graphics.

incbin "src/hello.chr"
