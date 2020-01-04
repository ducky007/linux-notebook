;These are "Default" handlers that don't do anything, I'm making the program use these until other code changes it.

defaultIrq:
defaultNmi:
	RTI

;This is the code that the CPU calls when an interrupt happens.  The IRQ Vector at the end of the ROM points here.
irqhandler:
	JMP (IrqJump)

;This is the code that the CPU calls when a Non-maskable interrupt (The Vblank interrupt from the PPU) happens.  The NMI Vector at the end of the ROM points here.
nmihandler:	
	INC Vblanked
	JMP (NmiJump)

;This is code used when the NES is "warming up".  It waits for the vblank-flag from PPU Status to become set.
WaitVblSet:
	bit PPUSTATUS   ;reading from PPU Status (address $2002)
	;The BIT instruction sets the "negative" flag when the most significant bit is 1, and clears it otherwise.  We are checking for bit $80.
	bpl WaitVblSet  ;Keep checking it again if the value is 0, which is a "positive" number
	rts

;This is code used when the NES is "warming up".  It waits for the vblank-flag from PPU Status to become clear (zero)
WaitVblClear:
	bit PPUSTATUS	;reading from PPU Status (address $2002)
	bmi WaitVblClear	;Keep checking it again if the value is #$80, which is a "negative" number
	rts

start:
	;Disable interrupts (they start out disabled anyway, but still...)
	sei
	;Disable Decimal Mode (which doesn't exist on the NES)
	cld
	
	;Initialize the stack by setting it to $FF
	ldx #$ff
	txs
	
	;Get a zero value by incrementing $FF to $00
	inx
	
	;Stop all sound
	stx SNDCHN
	stx PPUCTRL
	stx PPUMASK
	stx $4011
	
	lda #$40  ;disable APU frame IRQ, this is almost always unwanted.
	sta $4017
	
	;Wait for VBL flag to become set.
	jsr WaitVblSet
	
	;set A to 0 by copying X to A.
	txa

	;Clear all RAM 0000-07FF
ramclrloop:
	sta 0,X
	sta $100,X
	sta $200,X
	sta $300,X
	sta $400,X
	sta $500,X
	sta $600,X
	sta $700,X
	inx
	bne ramclrloop

	;Wait for the NES to warm up by running these four delay loops.
	jsr WaitVblSet
	jsr WaitVblSet
	jsr WaitVblClear
	jsr WaitVblSet
	
	;Set the default NMI and IRQ handlers, so we have a place to jump to.
	lda #defaultNmi & $FF
	sta NmiJump
	sta IrqJump
	lda #defaultNmi >> 8
	sta NmiJump+1
	sta IrqJump
	
	lda #$A8		;8x16 spr, right obj, left bg, enable NMI, advance 1
	sta PPUCTRL
	
	;Start the program
	JMP Main
	