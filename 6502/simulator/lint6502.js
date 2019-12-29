'use strict'

const opCodes = {
  ADC: 'Add with carry',
  AND: 'And',
  ASL: 'Arithmetic shift left',
  BCC: 'Branch on carry clear',
  BCS: 'Branch on carry set',
  BEQ: 'Branch on equal',
  BIT: 'Bit test',
  BMI: 'Branch on minus',
  BNE: 'Branch on not equal',
  BPL: 'Branch on plus',
  BRK: 'Break / interrupt',
  BVC: 'Branch on overflow clear',
  BVS: 'Branch on overflow set',
  CLC: 'Clear carry',
  CLD: 'Clear decimal',
  CLI: 'Clear interrupt disable',
  CLV: 'Clear overflow',
  CMP: 'Compare with accumulator',
  CPX: 'Compare with X',
  CPY: 'Compare with Y',
  DEC: 'Decrement',
  DEX: 'Decrement X',
  DEY: 'Decrement Y',
  EOR: 'Exclusive or',
  INC: 'Increment',
  INX: 'Increment X',
  INY: 'Increment Y',
  JMP: 'Jump',
  JSR: 'Jump subroutine',
  LDA: 'Load accumulator',
  LDX: 'Load X',
  LDY: 'Load Y',
  LSR: 'Logical shift right',
  NOP: 'No operation',
  ORA: 'Or with accumulator',
  PHA: 'Push accumulator onto stack',
  PHP: 'Push processor status onto stack',
  PLA: 'Pull accumulator from stack',
  PLP: 'Pull processor status from stack',
  ROL: 'Rotate left',
  ROR: 'Rotate right',
  RTI: 'Return from interrupt',
  RTS: 'Return from subroutine',
  SBC: 'Subtract with carry',
  SEC: 'Set carry',
  SED: 'Set decimal',
  SEI: 'Set interrupt disable',
  STA: 'Store accumulator',
  STX: 'Store X',
  STY: 'Store Y',
  TAX: 'Transfer accumulator to X',
  TAY: 'Transfer accumulator to Y',
  TSX: 'Transfer stack pointer to X',
  TXA: 'Transfer X to accumulator',
  TXS: 'Transfer X to stack pointer',
  TYA: 'Transfer Y to accumulator'
}

function lint6502 (text) {
  const lines = text.split('\n').filter((line) => { return line.trim() !== '' })

  function ucOpCodes (line) {
    return line.split(' ').map((word) => {
      return opCodes[word.toUpperCase()] ? word.toUpperCase() : word
    }).join(' ')
  }

  function catComment (line, prev) {
    if (line.trim().substr(0, 1) !== ';') { return line }
    return '; ' + line.replace(';', '').trim()
  }

  function subRoutine (line){
    if (line.trim().split(' ')[0].indexOf(':') < 0) { return line }
    return '\n'+line
  }

  for (const id in lines) {
    lines[id] = ucOpCodes(lines[id])
    lines[id] = catComment(lines[id], lines[id - 1])
    lines[id] = subRoutine(lines[id], lines[id - 1])
  }
  return lines.join('\n')
}
