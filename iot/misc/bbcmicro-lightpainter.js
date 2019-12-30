function makeSprite(letter: string) {
    if (letter == 'a') {
        return [
            0, 0, 1, 0, 0,
            0, 1, 0, 1, 0,
            1, 1, 1, 1, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1
        ]
    }
    else if (letter == 'b') {
        return [
            1, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 1, 1, 1, 0
        ]
    }
    else if (letter == 'c') {
        return [
            0, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 0,
            1, 0, 0, 0, 1,
            0, 1, 1, 1, 0
        ]
    }
    else if (letter == 'd') {
        return [
            1, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            1, 1, 1, 1, 0
        ]
    }
    else if (letter == 'e') {
        return [
            1, 1, 1, 1, 1,
            1, 0, 0, 0, 0,
            1, 1, 1, 1, 1,
            1, 0, 0, 0, 0,
            1, 1, 1, 1, 1
        ]
    }
    else if (letter == 'f') {
        return [
            1, 1, 1, 1, 1,
            1, 0, 0, 0, 0,
            1, 1, 1, 1, 1,
            1, 0, 0, 0, 0,
            1, 0, 0, 0, 0
        ]
    }
    else if (letter == 'g') {
        return [
            0, 1, 1, 1, 1,
            1, 0, 0, 0, 0,
            1, 0, 1, 1, 1,
            1, 0, 0, 0, 1,
            0, 1, 1, 1, 0
        ]
    }
    else if (letter == 'h') {
        return [
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            1, 1, 1, 1, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1
        ]
    }
    else if (letter == 'i') {
        return [
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0
        ]
    }
    else if (letter == 'j') {
        return [
            1, 1, 1, 1, 1,
            0, 0, 0, 0, 1,
            0, 0, 0, 0, 1,
            0, 0, 0, 0, 1,
            1, 1, 1, 1, 0
        ]
    }
    else if (letter == 'k') {
        return [
            1, 0, 0, 0, 1,
            1, 0, 0, 1, 0,
            1, 1, 1, 0, 0,
            1, 0, 0, 1, 0,
            1, 0, 0, 0, 1
        ]
    }
    else if (letter == 'l') {
        return [
            1, 0, 0, 0, 0,
            1, 0, 0, 0, 0,
            1, 0, 0, 0, 0,
            1, 0, 0, 0, 0,
            1, 1, 1, 1, 1
        ]
    }
    else if (letter == 'm') {
        return [
            1, 0, 0, 0, 1,
            1, 1, 0, 1, 1,
            1, 0, 1, 0, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1
        ]
    }
    else if (letter == 'n') {
        return [
            1, 0, 0, 0, 1,
            1, 1, 0, 0, 1,
            1, 0, 1, 0, 1,
            1, 0, 0, 1, 1,
            1, 0, 0, 0, 1
        ]
    }
    else if (letter == 'o') {
        return [
            0, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            0, 1, 1, 1, 0
        ]
    }
    else if (letter == 'p') {
        return [
            1, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 1, 1, 1, 0,
            1, 0, 0, 0, 0,
            1, 0, 0, 0, 0
        ]
    }
    else if (letter == 'q') {
        return [
            0, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 0, 1, 0, 1,
            1, 0, 0, 1, 1,
            0, 1, 1, 1, 1
        ]
    }
    else if (letter == 'r') {
        return [
            1, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 1, 1, 1, 0,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1
        ]
    }
    else if (letter == 's') {
        return [
            0, 1, 1, 1, 1,
            1, 0, 0, 0, 1,
            0, 1, 1, 1, 0,
            0, 0, 0, 0, 1,
            1, 1, 1, 1, 0
        ]
    }
    else if (letter == 't') {
        return [
            1, 1, 1, 1, 1,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0
        ]
    }
    else if (letter == 'u') {
        return [
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            0, 1, 1, 1, 0
        ]
    }
    else if (letter == 'u') {
        return [
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            1, 0, 0, 0, 1,
            0, 1, 0, 1, 0,
            0, 0, 1, 0, 0
        ]
    }
    else if (letter == 'w') {
        return [
            1, 0, 1, 0, 1,
            1, 0, 1, 0, 1,
            1, 0, 1, 0, 1,
            1, 0, 1, 0, 1,
            0, 1, 0, 1, 0
        ]
    }
    else if (letter == 'x') {
        return [
            1, 0, 0, 0, 1,
            0, 1, 0, 1, 0,
            0, 0, 1, 0, 0,
            0, 1, 0, 1, 0,
            1, 0, 0, 0, 1
        ]
    }
    else if (letter == 'y') {
        return [
            1, 0, 0, 0, 1,
            0, 1, 0, 1, 0,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 1, 0, 0
        ]
    }
    else if (letter == 'z') {
        return [
            1, 1, 1, 1, 1,
            0, 0, 0, 1, 0,
            0, 0, 1, 0, 0,
            0, 1, 0, 0, 0,
            1, 1, 1, 1, 1
        ]
    }
    else {
        return [
            0, 0, 0, 0, 0,
            0, 0, 0, 0, 0,
            0, 0, 0, 0, 0,
            0, 0, 0, 0, 0,
            0, 0, 0, 0, 0
        ]
    }
}

const word = ' microbit'
let active: boolean = false
let i: number = 0
let l: number = 0

function drawLetter(letter: string, slice: number) {
    const sprite = makeSprite(letter)
    const line = [sprite[slice], sprite[slice + 5], sprite[slice + 10], sprite[slice + 15], sprite[slice + 20]]
    if (line[0] == 1) { led.plot(2, 0) }
    if (line[1] == 1) { led.plot(2, 1) }
    if (line[2] == 1) { led.plot(2, 2) }
    if (line[3] == 1) { led.plot(2, 3) }
    if (line[4] == 1) { led.plot(2, 4) }
}

input.onButtonPressed(Button.A, function () {
    active = active == true ? false : true
    i = 0
    l = 0
})

input.onButtonPressed(Button.B, function () {
    i = 0
    l = 0
})

basic.forever(function () {
    if (active == false) {
        basic.clearScreen()
        return
    }
    if (l >= word.length) {
        active = false
        i = 0
        l = 0
        return
    }

    basic.pause(50)
    basic.clearScreen()

    const letter: string = word.substr(l % word.length, 1)
    const slice: number = i % 6

    if (slice < 5) {
        drawLetter(letter, slice)
    }

    i++

    if (i % 6 === 0) {
        l++
    }
})
