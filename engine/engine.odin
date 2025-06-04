package engine

import "core:fmt"
import "core:strings"

// For backend
import rl "vendor:raylib"

//-ESTROENGINE BEGIN

echo :: proc() {
    fmt.println("Hello, Robin!")
}

//-VECTOR BEGIN

// A simple type for storing two numbers of the same type and doing math on them, etc.
Vector2 :: struct($T: typeid) {
    x: T,
    y: T,
}

// Creates a Vector2.
Vector2_Create :: proc(x: $T , y: T) -> Vector2(T) {
    return {x, y}
}

Vector2_Cast :: proc(vector: Vector2($T), $T2: typeid) -> Vector2(T2) {
    return {T2(vector.x), T2(vector.y)}
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

// Creates a Vector3.
Vector3_Create :: proc(x: $T, y: T, z: T) -> Vector3(T) {
    return {x, y, z}
}

Vector3_Cast :: proc(vector: Vector3($T), $T2: typeid) -> Vector3(T2) {
    return {T2(vector.x), T2(vector.y), T2(vector.z)}
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

// VECTOR END

//-COLOR BEGIN

// A simple type to represent colors.
Color :: struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
}

// Creates a Color from HSV values. Values are from "0.0" to "1.0".
Color_Create_HSV :: proc(hue: f32, saturation: f32, value: f32, alpha: u8) -> Color {
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

    result.a = alpha

    return result
}

// Creates a Color.
Color_Create :: proc(red: u8, green: u8, blue: u8, alpha: u8 = 255) -> Color {
    return {red, green, blue, alpha}
}

DefaultColors :: struct{
    White: Color,
    Black: Color,
    Red: Color,
    Green: Color,
    Blue: Color,
    Gray: Color,
    DarkGray: Color,
    LightGray: Color,
    Pink: Color,
    Yellow: Color,
    Brown: Color,
    Purple: Color,
    HotPink: Color,
    Estrogen: Color,
}

// Get a struct of all the base colors in estroengine.
DefaultColors_Create :: proc() -> DefaultColors {
    return {
        {250, 250, 250, 255}, // White
        {0, 0, 0, 255}, // Black
        {255, 0, 0, 255}, // Red
        {0, 255, 0, 255}, // Green
        {0, 0, 255, 255}, // Blue
        {128, 128, 128, 255}, // Gray
        {48, 48, 48, 255}, // DarkGray
        {192, 192, 192, 255}, // LightGray
        {255, 0, 220, 255}, // Pink
        {255, 216, 0, 255}, // Yellow
        {84, 45, 19, 255}, // Brown
        {140, 0, 255, 255}, // Purple
        {255, 0, 110, 255}, // HotPink
        {142, 236, 255, 255}, // Estrogen
    }
}

// COLOR END

//-SHAPES BEGIN

Rectangle :: struct($T: typeid) {
    position: Vector2(T),
    size: Vector2(T),
}

// Creates a rectangle.
Rectangle_Create :: proc($T: typeid, position: Vector2(T), size: Vector2(T)) -> Rectangle(T) {
    return {position, size}
}

Rectangle_Cast :: proc(rectangle: Rectangle($T1), $T2: typeid) -> Rectangle(T2) {
    return {Vector2_Cast(rectangle.position, T2), Vector2_Cast(rectangle.size, T2)}
}

Circle :: struct($T: typeid) {
    position: Vector2(T),
    radius: T,
}

// Creates a circle.
Circle_Create :: proc($T: typeid, position: Vector2(T), radius: T) -> Circle(T) {
    return {position, radius}
}

// SHAPES END

//-LIST BEGIN

List :: struct($T: typeid){
    data: [dynamic]T
}

List_Add :: proc(list: ^List($T), value: T) {
    append(&list.data, value)
}

List_Append_Value :: proc(list: ^List($T), value: T) {
    append(&list.data, value)
}

List_Append_List :: proc(list: ^List($T), list2: [dynamic]T) {
    for value in List {
        List_Append_Value(&list.data, value)
    }
}

List_Insert :: proc(list: ^List($T), value: T, index: u32) {
    inject_at(&list.data, value, index)
}

List_Remove :: proc(list: ^List($T), index: u32) {
    ordered_remove(&list.data, index)
}

List_UnorderedRemove :: proc(list: ^List($T), index: u32) {
    unordered_remove(&list.data, index)
}

List_Append :: proc{
    List_Append_Value,
    List_Append_List,
}

// LIST END

//-NODES BEGIN

// A basic node with no position.
Node :: struct {
    id: int
}

// A basic node with a 2D position.
Node2D :: struct {
    using node: Node,
    position: Vector2(f32),
}

// A basic node with a 3D position.
Node3D :: struct {
    using node: Node,
    position: Vector3(f32),
}

// NODES END

MouseButton :: enum {
    Left,
    Right,
    Middle,
}

Key :: enum u8 {
    Unknown,
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
    OpenBracket,
    CloseBracket,
    Tab,
    Backslash,
    Dash,
    Equal,
    Semicolon,
    LeftShift,
    RightShift,
    LeftControl,
    RightControl,
    Grave,
    Comma,
    Period,
    Slash,
    LeftAlt,
    RightAlt,
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
    Space,
    Enter,
    Escape,
    Apostrophe,
}

// ESTROENGINE END

//-PROCESS GROUPS BEGIN

// Generic group for adding two estroengine types.
Add :: proc {
    Add_Vector2,
    Add_Vector3,
}

// Generic group for subtracting two estroengine types.
Subtract :: proc {
    Subtract_Vector2,
    Subtract_Vector3,
}

// Generic group for multiplying two estroengine types.
Multiply :: proc {
    Multiply_Vector2,
    Multiply_Vector3,
}

// Generic group for dividing two estroengine types.
Divide :: proc {
    Divide_Vector2,
    Divide_Vector3,
}

Cast :: proc {
    Vector2_Cast,
    Vector3_Cast,
    Rectangle_Cast,
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
 
//-BACKEND WRAPPER FUNCTIONS BEGIN

// A simple texture struct.
Texture :: struct {
    data: rl.Texture2D,
}

// A simple audio struct for sounds, music, etc.
Sound :: struct {
    data: rl.Sound,
}

// Loads a texture from the specified filename.
Texture_LoadFromFile :: proc(texture: ^Texture, filename: string) {
    texture^.data = rl.LoadTexture(strings.clone_to_cstring(filename))
}

// Unload a texture.
Texture_Unload :: proc(texture: ^Texture) {
    rl.UnloadTexture(texture.data)
}

// Loads a sound from the specified filename.
Audio_LoadFromFile :: proc(sound: ^Sound, filename: string) {
    sound^.data = rl.LoadSound(strings.clone_to_cstring(filename))
}

// Unload a sound.
Sound_Unload :: proc(sound: ^Sound) {
    rl.UnloadSound(sound.data)
}

// Initialize the window with a specific size and Title.
InitWindow :: proc(size: Vector2(u32), window_title: string) {
    rl.InitWindow(i32(size.x), i32(size.y), strings.clone_to_cstring(window_title))
}

// Is the window still open? (Can be closed by X, Esc, etc.)
IsWindowOpen :: proc() -> bool {
    return !rl.WindowShouldClose()
}

// Used to begin the drawing phase of a frame.
DrawBegin :: proc() {
    rl.BeginDrawing()
}

// Used to end the drawing phase of a frame.
DrawEnd :: proc() {
    rl.EndDrawing()
}

// Clears the entire screen with a single color.
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

// Checks if the specified key is held down.
Key_IsHeld :: proc(key: Key) -> bool {
    return rl.IsKeyDown(Key_ToRaylibKey(key))
}

// Checks if the specified key has been held for a bit. (Useful for text processors)
Key_IsHeldRepeat :: proc(key: Key) -> bool {
    return rl.IsKeyPressedRepeat(Key_ToRaylibKey(key))
}

// Checks if the specified key has just been pressed this frame.
Key_IsPressed :: proc(key: Key) -> bool {
    return rl.IsKeyPressed(Key_ToRaylibKey(key))
}

// Checks if the specified key has just been released this frame.
Key_IsReleased :: proc(key: Key) -> bool {
    return rl.IsKeyReleased(Key_ToRaylibKey(key))
}

// Get the cursor's position.
Cursor_GetPosition :: proc() -> Vector2(i32) {
    return {rl.GetMouseX(), rl.GetMouseY()}
}

// Set the cursor's position.
Cursor_SetPosition :: proc(position: Vector2(i32)) {
    rl.SetMousePosition(position.x, position.y)
}

Mouse_IsHeld :: proc(button: MouseButton) -> bool {
    if rlbutton, ok := MouseButton_ToRaylibMouseButton(button); ok {
        return rl.IsMouseButtonDown(rlbutton)
    }

    return false
}

Mouse_IsPressed :: proc(button: MouseButton) -> bool {
    if rlbutton, ok := MouseButton_ToRaylibMouseButton(button); ok {
        return rl.IsMouseButtonPressed(rlbutton)
    }

    return false
}

Mouse_IsReleased :: proc(button: MouseButton) -> bool {
    if rlbutton, ok := MouseButton_ToRaylibMouseButton(button); ok {
        return rl.IsMouseButtonReleased(rlbutton)
    }

    return false
}

// BACKEND WRAPPER FUNCTIONS END

Input_IsHeld :: proc{
    Key_IsHeld,
    Mouse_IsHeld,
}

Input_IsPressed :: proc{
    Key_IsPressed,
    Mouse_IsPressed,
}

Input_IsReleased :: proc{
    Key_IsReleased,
    Mouse_IsReleased,
}