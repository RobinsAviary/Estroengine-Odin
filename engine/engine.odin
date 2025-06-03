package engine

import "core:fmt"
import rl "vendor:raylib"
import "core:strings"

//-ESTROENGINE BEGIN

echo :: proc() {
    fmt.println("Hello, Robin!")
}

// A simple type for storing two numbers of the same type and doing math on them, etc.
Vector2 :: struct($T: typeid) {
    x: T,
    y: T,
}

Vector2_Create :: proc(x: $T , y: T) -> Vector2(T) {
    return {x, y}
}

Add_Vector2 :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x + vec2.x, vec1.y + vec2.y}
}

Subtract_Vector2 :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x - vec2.x, vec1.y - vec2.y}
} 

Multiply_Vector2 :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x * vec2.x, vec1.y * vec2.y}
}

Divide_Vector2 :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x / vec2.x, vec1.y / vec2.y}
}

// A simple type for storing three numbers of the same type and doing math on them, etc.
Vector3 :: struct($T: typeid) {
    x: T,
    y: T,
    z: T,
}

Vector3_Create :: proc(x: $T, y: T, z: T) -> Vector3(T) {
    return {x, y, z}
}

Add_Vector3 :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x + vec2.x, vec1.y + vec2.y, vec1.z + vec2.z}
}

Subtract_Vector3 :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x - vec2.x, vec1.y - vec2.y, vec1.z - vec2.z}
}

Multiply_Vector3 :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x * vec2.x, vec1.y * vec2.y, vec1.z * vec2.z}
}

Divide_Vector3 :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x / vec2.x, vec1.y / vec2.y, vec1.z / vec2.z}
}

// A simple type to represent colors.
Color :: struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
}

// Creates a Color from HSV values. Values are from "0.0" to "1.0".
Color_Create_HSV :: proc(hue: f32, saturation: f32, value: f32) -> Color {
    hue := hue // Makes variable mutable
    hue *= 360
    
    result: Color

    max: u8 = u8(value)
    chroma: f32 = saturation * value
    min: u8 = max - u8(chroma)

    if (hue >= 300) {
        hue -= 360
        hue /= 60
    }
    else {
        hue = hue / 60
    }

    if (hue < 0) {
        result.r = max
        result.g = min
        result.b = min - u8(hue * chroma)
    }
    else if (hue >= 0) {
        result.r = max
        result.b = min + u8(hue * chroma)
        result.b = min
    }
    else if (hue - 2 < 0) {
        result.r = min - u8((hue - 2) * chroma)
        result.g = max
        result.b = min
    }
    else if (hue - 2 >= 0) {
        result.r = min
        result.g = max
        result.b = result.r + u8((hue - 2) * chroma)
    }
    else if (hue - 4 < 0) {
        result.r = min
        result.g = min - u8((hue - 4) * chroma)
        result.b = max
    }
    else if ( hue - 4 >= 0) {
        result.r = min + u8((hue - 4) * chroma)
        result.g = min
        result.b = max
    }
    result.a = 1

    return result
}

Color_Create_RGB :: proc(red: u8, green: u8, blue: u8) -> Color {
    return {red, green, blue, 1}
}

Color_Create_RGBA :: proc(red: u8, green: u8, blue: u8, alpha: u8) -> Color {
    return {red, green, blue, alpha}
}

Color_Create_HSVA :: proc(hue: f32, saturation: f32, value: f32, alpha: u8) -> Color {
    result: Color

    result = Color_Create_HSV(hue, saturation, value)

    result.a = alpha

    return result
}

Rectangle :: struct($T: typeid) {
    position: Vector2(T),
    size: Vector2(T),
}

Circle :: struct($T: typeid) {
    position: Vector2(T),
    radius: T,
}

Node :: struct {
    id: int
}

Node2D :: struct {
    using node: Node,
    position: Vector2(f32),
}

Node3D :: struct {
    using node: Node,
    position: Vector3(f32),
}

Key :: enum {
    Q,
    W,
    E,
    R,
    T,
    Y,
    U,
    I,
    O,
    P,
    A,
    S,
    D,
    F,
    G,
    H,
    J,
    K,
    L,
    Z,
    X,
    C,
    V,
    B,
    N,
    M,
    One,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Zero,
    Exclamation,
    At,
    NumberSign,
    Dollar,
    Percent,
    Carrot,
    Ampersand,
    Asterisk,
    OpenParenthesis,
    CloseParenthesis,
    OpenBracket,
    CloseBracket,
    Tab,
    OpenCurly,
    CloseCurly,
    BackSlash,
    Pipe,
    Dash,
    Underscore,
    Equal,
    Plus,
    Colon,
    Semicolon,
    LeftShift,
    RightShift,
    Shift,
    LeftControl,
    RightControl,
    Control,
    SmallQuote,
    Quote,
    Comma,
    LessThan,
    Period,
    GreaterThan,
    Slash,
    QuestionMark,
    InvertedComma,
    Tilde,
    LeftAlt,
    RightAlt,
    Alt,
    NumpadZero,
    NumpadOne,
    NumpadTwo,
    NumpadThree,
    NumpadFour,
    NumpadFive,
    NumpadSix,
    NumpadSeven,
    NumpadEight,
    NumpadNine,
    NumpadDot,
    NumpadPlus,
    NumpadMinus,
    NumpadDivide,
    NumpadMultiply,
    NumpadEnter,
    Insert,
    Home,
    PageUp,
    Delete,
    End,
    PageDown,
    F1,
    F2,
    F3,
    F4,
    F5,
    F6,
    F7,
    F8,
    F9,
    F10,
    F11,
    F12,
    CapsLock,
    PrintScreen,
    Up,
    Down,
    Left,
    Right,
}

// ESTROENGINE END

//-PROCESS GROUPS BEGIN

Add :: proc {
    Add_Vector2,
    Add_Vector3,
}

Subtract :: proc {
    Subtract_Vector2,
    Subtract_Vector3,
}

Multiply :: proc {
    Multiply_Vector2,
    Multiply_Vector3,
}

Divide :: proc {
    Divide_Vector2,
    Divide_Vector3,
}
// PROCESS GROUPS END

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

Rectangle_ToRaylibRectangle :: proc(rectangle: Rectangle($T)) {
    return {rectangle.position.x, rectangle.position.y, rectangle.size.x, rectangle.size.y}
}

// RAYLIB CONVERSION FUNCTIONS END
 
//-BACKEND WRAPPER FUNCTIONS BEGIN

Texture :: struct {
    data: rl.Texture2D,
}

Audio :: struct {
    data: rl.Sound,
}

Texture_LoadFromFile :: proc(texture: ^Texture, filename: string) {
    texture^.data = rl.LoadTexture(strings.clone_to_cstring(filename))
}

Texture_Unload :: proc(texture: ^Texture) {
    rl.UnloadTexture(texture^.data)
}

Audio_LoadFromFile :: proc(audio: ^Audio, filename: string) {
    audio^.data = rl.LoadSound(strings.clone_to_cstring(filename))
}

Audio_Unload :: proc(audio: ^Audio) {
    rl.UnloadSound(audio^.data)
}

InitWindow :: proc(size: Vector2(u32), window_title: string) {
    rl.InitWindow(i32(size.x), i32(size.y), strings.clone_to_cstring(window_title))
}

IsWindowOpen :: proc() -> bool {
    return !rl.WindowShouldClose()
}

DrawBegin :: proc() {
    rl.BeginDrawing()
}

DrawEnd :: proc() {
    rl.EndDrawing()
}

DrawClearColor :: proc(color: Color) {
    rl.ClearBackground(Color_ToRaylibColor(color))
}

DrawRectangle :: proc(rectangle: Rectangle($T), color: Color) {
    rl.DrawRectangleV(Vector2_ToRaylibVector2(rectangle.position), Vector2_ToRaylibVector2(rectangle.size), Color_ToRaylibColor(color))
}

DrawRectangleLines :: proc(rectangle: Rectangle($T), color: Color, thickness: f32) {
    rl.DrawRectangleLinesEx(Rectangle_ToRaylibRectangle(rectangle), thickness, Color_ToRaylibColor(color))
}

DrawLine :: proc(startPos: Vector2($T), endPos: Vector2(T), color: Color, thickness: f32 = 1) {
    rl.DrawLineEx(Vector2_ToRaylibVector2(startPos), Vector2_ToRaylibVector2(endPos), thickness, Color_ToRaylibColor(color))
}

DrawCircle :: proc(circle: Circle($T), color: Color) {
    rl.DrawCircleV(Vector2_ToRaylibVector2(circle.position), circle.radius, Color_ToRaylibColor(color))
}

DrawCircleLines :: proc(circle: Circle($T), color: Color, thickness: f32 = 1) {
    rl.DrawCircleLinesV(Vector2_ToRaylibVector2(circle.position), circle.radius, color)
}

DrawTexture :: proc(texture: Texture, position: Vector2($T), color: Color) {
    rl.DrawTexture(texture.data, position.x, position.y, Color_ToRaylibColor(color))
}

/*Key_ToRaylibKeys :: proc(key: Key) -> rl.KeyboardKey {
    switch key {
        case .A:
            return rl.KeyboardKey.A
        
        case .Alt:
            return (rl.KeyboardKey.LEFT_ALT || rl.KeyboardKey.RIGHT_ALT)
        
        case .Ampersand:
            return rl.KeyboardKey.SEVEN
    }
}
*/

// BACKEND WRAPPER FUNCTIONS END