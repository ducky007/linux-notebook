; These are "Default" handlers that don't do anything, 
; I'm making the program use these until other code changes it.

defaultIrq:
defaultNmi:
	RTI

; This is the code that the CPU calls when an interrupt happens.  
; The IRQ Vector at the end of the ROM points here.

irqhandler:
	JMP (IrqJump)

; This is the code that the CPU calls when a Non-maskable interrupt happens.  
; The NMI Vector at the end of the ROM points here.

nmihandler:	
	INC Vblanked
	JMP (NmiJump)

; This is code used when the NES is "warming up".  
; It waits for the vblank-flag from PPU Status to become set.
; Reading from PPU Status (address $2002).
; Keep checking it again if the value is 0, which is a "positive" number.

WaitVblSet:
	bit PPUSTATUS   	
	bpl WaitVblSet  
	rts

; This is code used when the NES is "warming up".  
; It waits for the vblank-flag from PPU Status to become clear (zero).
; Reading from PPU Status (address $2002)
; Keep checking it again if the value is #$80, which is a "negative" number.

WaitVblClear:
	bit PPUSTATUS	
	bmi WaitVblClear	
	rts

start:
	sei                  ; Disable interrupts
	cld                  ; Disable Decimal Mode
	
	ldx #$ff             ; Initialize the stack by setting it to $FF
	txs
	
	inx                  ; Get a zero value by incrementing $FF to $00
	
	stx SNDCHN           ; Stop all sound
	stx PPUCTRL
	stx PPUMASK
	stx $4011
	
	lda #$40             ; Disable APU frame IRQ
	sta $4017
	
	jsr WaitVblSet       ; Wait for VBL flag to become set.
	txa                  ; set A to 0 by copying X to A.

	
ramclrloop:            ; Clear all RAM 0000-07FF
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

	jsr WaitVblSet       ; Wait for the NES to warm up.
	jsr WaitVblSet
	jsr WaitVblClear
	jsr WaitVblSet
	
	; Set the default NMI and IRQ handlers.

	lda #defaultNmi & $FF 
	sta NmiJump
	sta IrqJump
	lda #defaultNmi >> 8
	sta NmiJump+1
	sta IrqJump
	
	lda #$A8		         ; 8x16 spr, right obj, left bg, enable NMI, advance 1
	sta PPUCTRL
	
	JMP Main             ; Start the program
