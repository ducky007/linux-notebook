'use strict'

function Planner () {
  const screen = { w: 32, h: 30 }
  const scale = 15
  this.isMouseDown = false
  this.brush = 1
  this.el = document.createElement('canvas')
  this.context = this.el.getContext('2d')
  this.data = new Array(screen.w * screen.h)
  this.exportButton = document.createElement('button')
  this.lessButton = document.createElement('button')
  this.moreButton = document.createElement('button')
  this.colors = ['white', 'black', 'grey', 'red', '#72dec2', 'yellow', 'blue', 'pink']

  this.install = (host) => {
    this.exportButton.innerHTML = 'export'
    this.lessButton.innerHTML = '<'
    this.moreButton.innerHTML = '>'

    host.appendChild(this.el)
    host.appendChild(this.exportButton)
    host.appendChild(this.lessButton)
    host.appendChild(this.moreButton)

    this.el.width = screen.w * scale
    this.el.height = screen.h * scale

    this.el.onmousedown = this.onMouseDown
    this.el.onmousemove = this.onMouseMove
    this.el.onmouseup = this.onMouseUp

    this.exportButton.onclick = this.onClick
    this.moreButton.onclick = this.moreClick
    this.lessButton.onclick = this.lessClick
  }

  this.start = () => {
    console.log('started')
    this.update()
  }

  this.moreClick = () => {
    if (this.brush > 15) { return }
    this.brush++
  }

  this.lessClick = () => {
    if (this.brush < 1) { return }
    this.brush--
  }

  this.onMouseDown = (e) => {
    this.isMouseDown = true
    const pos = { x: e.clientX - 30, y: e.clientY - 30 }
  }

  this.onMouseMove = (e) => {
    if (!this.isMouseDown) { return }
    const pos = { x: e.clientX - 30, y: e.clientY - 30 }
    this.setTile(posToId(pos), this.brush)
    this.update()
  }

  this.onMouseUp = (e) => {
    this.isMouseDown = false
    const pos = { x: e.clientX - 30, y: e.clientY - 30 }
  }

  this.onClick = (e) => {
    console.log(this.output())
    this.printOutput()
  }

  this.update = () => {
    this.clear()
    this.drawTiles()
    this.drawGrid()
  }

  this.clear = () => {
    this.context.clearRect(0, 0, this.el.width, this.el.height)
  }

  this.drawGrid = () => {
    for (var x = 0; x < screen.w; x++) {
      if (x == 0) { continue }
      this.drawLine({ x: x * scale, y: 0 }, { x: x * scale, y: screen.h * scale }, 32)
    }
    for (var y = 0; y < screen.h; y++) {
      if (y == 0) { continue }
      this.drawLine({ x: 0, y: y * scale }, { x: screen.w * scale, y: y * scale }, 30)
    }
  }

  this.drawTiles = () => {
    for (var x = 0; x < screen.w; x++) {
      for (var y = 0; y < screen.h; y++) {
        const id = x + (y * screen.w)
        if (this.data[id]) {
          this.drawTile({ x, y }, this.colors[this.data[id]])
        }
      }
    }
  }

  this.drawLine = (a, b, mid = 32) => {
    this.context.beginPath()
    this.context.moveTo(a.x, a.y)
    this.context.lineTo(b.x, b.y)

    if(a.x === (mid/2) * scale || a.y === (mid/2) * scale){
      this.context.strokeStyle = 'red'
    }
    else if(a.x === 0 && a.y === (scale * 1)){
      this.context.strokeStyle = 'blue'
    }
    else if(a.x === 0 && a.y === (scale * (30-1))){
      this.context.strokeStyle = 'blue'
    }
    else if(a.y === 0 && a.x === (scale * 2)){
      this.context.strokeStyle = 'blue'
    }
    else if(a.y === 0 && a.x === (scale * (32-2))){
      this.context.strokeStyle = 'blue'
    }
    else{
      this.context.strokeStyle = 'black'
    }
    this.context.stroke()
  }

  this.drawTile = (pos, color) => {
    this.context.beginPath()
    this.context.rect(pos.x * scale, pos.y * scale, scale, scale)
    this.context.fillStyle = color
    this.context.fill()
  }

  this.output = () => {
    let txt = ''

    for (var y = 0; y < screen.h; y++) {
      txt += '  .db '
      for (var x1 = 0; x1 < screen.w / 2; x1++) {
        const id = x1 + (y * screen.w)
        txt += `${toHex(this.data[id])}` + (x1 < (screen.w / 2) - 1 ? ',' : '')
      }
      txt += '\n'
      txt += '  .db '
      for (var x2 = 16; x2 < screen.w; x2++) {
        const id = x2 + (y * screen.w)
        txt += `${toHex(this.data[id])}` + (x2 < screen.w - 1 ? ',' : '')
      }
      txt += '\n'
    }
    return txt
  }

  //

  this.printOutput = () => {
    const myWindow = window.open('', 'MsgWindow', 'width=600,height=400')
    myWindow.document.write(`<pre>${this.output()}</pre>`)
  }

  //

  this.setTile = (id, val) => {
    this.data[id] = val
  }

  function cursorToPos (x, y) {
    return { x: x - 30, y: y - 30 }
  }

  function posKey (pos) {
    return `${pos.x}:${pos.y}`
  }

  function posToId (pos) {
    return Math.floor(pos.x / scale) + (Math.floor(pos.y / scale) * screen.w)
  }

  function toHex (int) {
    return '$' + (int || 0).toString(16).padStart(2, '0')
  }
}
