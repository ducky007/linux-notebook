The 6502 handles data in its registers, each of which holds one byte (8-bits) of data.  There are a total of three general use and two special purpose registers:

```  
accumulator (A)  -  Handles all arithmetic and logic.  The real heart of the system.
X and Y          -  General purpose registers with limited abilities.
S                -  Stack pointer.
P                -  Processor status.  Holds the result of tests and flags.
```

- LDA #$01 loads the hex value $01 into register A
- STA $0200 stores the value of the A register to memory location $0200
- CPX compares the value in the X register with another value. If the two values are equal, the Z flag is set to 1, otherwise it is set to 0.

- SP is the stack pointer. I won’t get into the stack yet, but basically this register is decremented every time a byte is pushed onto the stack, and incremented when a byte is popped off the stack.

- PC is the program counter - it’s how the processor knows at what point in the program it currently is. It’s like the current line number of an executing script. In the JavaScript simulator the code is assembled starting at memory location $0600, so PC always starts there.

- The last section shows the processor flags. Each flag is one bit, so all seven flags live in a single byte. The flags are set by the processor to give information about the previous instruction. More on that later. Read more about the registers and flags here.

```
LDA #$c0  ;Load the hex value $c0 into the A register
TAX       ;Transfer the value in the A register to X
INX       ;Increment the value in the X register
ADC #$c4  ;Add the hex value $c4 to the A register
BRK       ;Break - we're done
```

## Decrement

```
  LDX #$08
decrement:
  DEX
  STX $0200
  CPX #$03
  BNE decrement
  STX $0201
  BRK
```