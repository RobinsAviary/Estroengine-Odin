package engine
import rl "vendor:raylib"

//-RAYLIB CONVERSION FUNCTIONS BEGIN

Color_ToRaylibColor :: proc(color: Color) -> rl.Color {
    result: rl.Color 

    result.r = color.r
    result.g = color.g
    result.b = color.b
    result.a = color.a
    
    return result
}

Vector2_ToRaylibVector2 :: proc(vector: Vector2($T)) -> rl.Vector2 {
    return {vector.x, vector.y}
}

Vector3_ToRaylibVector3 :: proc(vector: Vector3($T)) -> rl.Vector3 {
    return {vector.x, vector.y, vector.z}
}

RaylibVector2_ToVector2 :: proc(vector: rl.Vector2, $T: typeid) -> Vector2(T) {
    return Vector2_Create(vector.x, vector.y, T)
}

RaylibVector3_ToVector3 :: proc(vector: rl.Vector3, $T: typeid) -> Vector3(T) {
    return Vector3_Create(T(vector.x), T(vector.y), T(vector.z))
}

Rectangle_ToRaylibRectangle :: proc(rectangle: Rectangle($T)) {
    return {rectangle.position.x, rectangle.position.y, rectangle.size.x, rectangle.size.y}
}

Key_ToRaylibKey :: proc(key: Key) -> rl.KeyboardKey {
    conversionTable: map[Key]rl.KeyboardKey
    conversionTable[.Q] = rl.KeyboardKey.Q
    conversionTable[.W] = rl.KeyboardKey.W
    conversionTable[.E] = rl.KeyboardKey.E
    conversionTable[.R] = rl.KeyboardKey.R
    conversionTable[.T] = rl.KeyboardKey.T
    conversionTable[.Y] = rl.KeyboardKey.Y
    conversionTable[.U] = rl.KeyboardKey.U
    conversionTable[.I] = rl.KeyboardKey.I
    conversionTable[.O] = rl.KeyboardKey.O
    conversionTable[.P] = rl.KeyboardKey.P
    conversionTable[.A] = rl.KeyboardKey.A
    conversionTable[.S] = rl.KeyboardKey.S
    conversionTable[.D] = rl.KeyboardKey.D
    conversionTable[.F] = rl.KeyboardKey.F
    conversionTable[.G] = rl.KeyboardKey.G
    conversionTable[.H] = rl.KeyboardKey.H
    conversionTable[.J] = rl.KeyboardKey.J
    conversionTable[.K] = rl.KeyboardKey.K
    conversionTable[.L] = rl.KeyboardKey.L
    conversionTable[.Z] = rl.KeyboardKey.Z
    conversionTable[.X] = rl.KeyboardKey.X
    conversionTable[.C] = rl.KeyboardKey.C
    conversionTable[.V] = rl.KeyboardKey.V
    conversionTable[.B] = rl.KeyboardKey.B
    conversionTable[.N] = rl.KeyboardKey.N
    conversionTable[.M] = rl.KeyboardKey.M
    conversionTable[.One] = rl.KeyboardKey.ONE
    conversionTable[.Two] = rl.KeyboardKey.TWO
    conversionTable[.Three] = rl.KeyboardKey.THREE
    conversionTable[.Four] = rl.KeyboardKey.FOUR
    conversionTable[.Five] = rl.KeyboardKey.FIVE
    conversionTable[.Six] = rl.KeyboardKey.SIX
    conversionTable[.Seven] = rl.KeyboardKey.SEVEN
    conversionTable[.Eight] = rl.KeyboardKey.EIGHT
    conversionTable[.Nine] = rl.KeyboardKey.NINE
    conversionTable[.Zero] = rl.KeyboardKey.ZERO
    conversionTable[.OpenBracket] = rl.KeyboardKey.LEFT_BRACKET
    conversionTable[.CloseBracket] = rl.KeyboardKey.RIGHT_BRACKET
    conversionTable[.Tab] = rl.KeyboardKey.TAB
    conversionTable[.Backslash] = rl.KeyboardKey.BACKSLASH
    conversionTable[.Dash] = rl.KeyboardKey.MINUS
    conversionTable[.Equal] = rl.KeyboardKey.EQUAL
    conversionTable[.Semicolon] = rl.KeyboardKey.SEMICOLON
    conversionTable[.LeftShift] = rl.KeyboardKey.LEFT_SHIFT
    conversionTable[.RightShift] = rl.KeyboardKey.RIGHT_SHIFT
    conversionTable[.LeftControl] = rl.KeyboardKey.LEFT_CONTROL
    conversionTable[.RightControl] = rl.KeyboardKey.RIGHT_CONTROL
    conversionTable[.Grave] = rl.KeyboardKey.GRAVE
    conversionTable[.Comma] = rl.KeyboardKey.COMMA
    conversionTable[.Period] = rl.KeyboardKey.PERIOD
    conversionTable[.Slash] = rl.KeyboardKey.SLASH
    conversionTable[.LeftAlt] = rl.KeyboardKey.LEFT_ALT
    conversionTable[.RightAlt] = rl.KeyboardKey.RIGHT_ALT
    conversionTable[.NumpadOne] = rl.KeyboardKey.KP_1
    conversionTable[.NumpadTwo] = rl.KeyboardKey.KP_2
    conversionTable[.NumpadThree] = rl.KeyboardKey.KP_3
    conversionTable[.NumpadFour] = rl.KeyboardKey.KP_4
    conversionTable[.NumpadFive] = rl.KeyboardKey.KP_5
    conversionTable[.NumpadSix] = rl.KeyboardKey.KP_6
    conversionTable[.NumpadSeven] = rl.KeyboardKey.KP_7
    conversionTable[.NumpadEight] = rl.KeyboardKey.KP_8
    conversionTable[.NumpadNine] = rl.KeyboardKey.KP_9
    conversionTable[.NumpadZero] = rl.KeyboardKey.KP_0
    conversionTable[.NumpadDot] = rl.KeyboardKey.KP_DECIMAL
    conversionTable[.NumpadPlus] = rl.KeyboardKey.KP_ADD
    conversionTable[.NumpadMinus] = rl.KeyboardKey.KP_SUBTRACT
    conversionTable[.NumpadDivide] = rl.KeyboardKey.KP_DIVIDE
    conversionTable[.NumpadMultiply] = rl.KeyboardKey.KP_MULTIPLY
    conversionTable[.Insert] = rl.KeyboardKey.INSERT
    conversionTable[.Home] = rl.KeyboardKey.HOME
    conversionTable[.PageUp] = rl.KeyboardKey.PAGE_UP
    conversionTable[.PageDown] = rl.KeyboardKey.PAGE_DOWN
    conversionTable[.F1] = rl.KeyboardKey.F1
    conversionTable[.F2] = rl.KeyboardKey.F2
    conversionTable[.F3] = rl.KeyboardKey.F3
    conversionTable[.F4] = rl.KeyboardKey.F4
    conversionTable[.F5] = rl.KeyboardKey.F5
    conversionTable[.F6] = rl.KeyboardKey.F6
    conversionTable[.F7] = rl.KeyboardKey.F7
    conversionTable[.F8] = rl.KeyboardKey.F8
    conversionTable[.F9] = rl.KeyboardKey.F9
    conversionTable[.F10] = rl.KeyboardKey.F10
    conversionTable[.F11] = rl.KeyboardKey.F11
    conversionTable[.F12] = rl.KeyboardKey.F12
    conversionTable[.CapsLock] = rl.KeyboardKey.CAPS_LOCK
    conversionTable[.PrintScreen] = rl.KeyboardKey.PRINT_SCREEN
    conversionTable[.Up] = rl.KeyboardKey.UP
    conversionTable[.Down] = rl.KeyboardKey.DOWN
    conversionTable[.Left] = rl.KeyboardKey.LEFT
    conversionTable[.Right] = rl.KeyboardKey.RIGHT
    conversionTable[.Space] = rl.KeyboardKey.SPACE
    conversionTable[.Enter] = rl.KeyboardKey.ENTER
    conversionTable[.Escape] = rl.KeyboardKey.ESCAPE
    conversionTable[.Apostrophe] = rl.KeyboardKey.APOSTROPHE
    conversionTable[.Unknown] = rl.KeyboardKey.KEY_NULL

    if result, ok := conversionTable[key]; ok {
        return result
    } else {
        return rl.KeyboardKey.KEY_NULL
    }
}

MouseButton_ToRaylibMouseButton :: proc(button: MouseButton) -> (rl.MouseButton, bool) {
    conversionTable: map[MouseButton]rl.MouseButton
    conversionTable[.Left] = rl.MouseButton.LEFT
    conversionTable[.Right] = rl.MouseButton.RIGHT
    conversionTable[.Middle] = rl.MouseButton.MIDDLE

    if result, ok := conversionTable[button]; ok {
        return result, true
    } else {
        return rl.MouseButton.EXTRA, false
    }
}

// RAYLIB CONVERSION FUNCTIONS END