package engine

import "core:strings"
import "core:math/rand"

// For backend
import rl "vendor:raylib"

//-ESTROENGINE BEGIN

//-VECTOR BEGIN

// A simple type for storing two numbers of the same type and doing math on them, etc.
Vector2 :: struct($T: typeid) {
    x: T,
    y: T,
}

// Creates a Vector2 by inferring the input type.
Vector2_CreateInfer :: proc(x: $T , y: T) -> Vector2(T) {
    return {x, y}
}

// Creates a Vector2 with a specific type.
Vector2_CreateType :: proc(x: $T1, y: T1, $T: typeid) -> Vector2(T) {
    return {T(x), T(y)}
}

// Generic group for creating a Vector2.
Vector2_Create :: proc{
    Vector2_CreateInfer,
    Vector2_CreateType,
}

// Casts a Vector2 to a different type.
Vector2_Cast :: proc(vector: Vector2($T), $T2: typeid) -> Vector2(T2) {
    return {T2(vector.x), T2(vector.y)}
}

// Adds two Vector2s and returns the result.
Add_Vector2 :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x + vec2.x, vec1.y + vec2.y}
}

// Subtracts two Vector2s and returns the result.
Subtract_Vector2 :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x - vec2.x, vec1.y - vec2.y}
} 

// Multiplies two Vector2s and returns the result.
Multiply_Vector2 :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x * vec2.x, vec1.y * vec2.y}
}

// Divides two Vector2s and returns the result.
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
Vector3_Create_T :: proc(x: $T, y: T, z: T) -> Vector3(T) {
    return {x, y, z}
}

// Creates a Vector3 using an existing Vector2 for x and y, and a third value for z.
Vector3_Create_Vector2T :: proc(xy: Vector2($T), z: T) {
    return {xy.x, xy.y, z}
}

// Creates a Vector3 using a value for x, and an existing Vector2 for y and z.
Vector3_Create_TVector2 :: proc(x: $T, yz: Vector2(T)) {
    return {x, yz.x, yz.y}
}

// Creates a Vector3.
Vector3_Create :: proc{
    Vector3_Create_T,
    Vector3_Create_TVector2,
    Vector3_Create_Vector2T,
}

// Casts a Vector3 to a different type.
Vector3_Cast :: proc(vector: Vector3($T), $T2: typeid) -> Vector3(T2) {
    return {T2(vector.x), T2(vector.y), T2(vector.z)}
}

// Adds two Vector3s and returns the result.
Add_Vector3 :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x + vec2.x, vec1.y + vec2.y, vec1.z + vec2.z}
}

// Subtracts two Vector3s and returns the result.
Subtract_Vector3 :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x - vec2.x, vec1.y - vec2.y, vec1.z - vec2.z}
}

// Multiplies two Vector3s and returns the result.
Multiply_Vector3 :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x * vec2.x, vec1.y * vec2.y, vec1.z * vec2.z}
}

// Divides two Vector3s and returns the result.
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

White: Color = {250, 250, 250, 255}
Black: Color = {0, 0, 0, 255}
Red: Color = {255, 0, 0, 255}
Blue: Color = {0, 0, 255, 255}
Gray: Color = {128, 128, 128, 255}
DarkGray: Color = {48, 48, 48, 255}
LightGray: Color = {192, 192, 192, 255}
Pink: Color = {255, 0, 220, 255}
Yellow: Color = {255, 216, 0, 255}
Brown: Color = {84, 45, 19, 255}
Purple: Color = {140, 0, 255, 255}
HotPink: Color = {255, 0, 110, 255}
Estrogen: Color = {142, 236, 255, 255}

// COLOR END

//-SHAPES BEGIN

// A basic struct for defining a Rectangle shape.
Rectangle :: struct($T: typeid) {
    position: Vector2(T),
    size: Vector2(T),
}

// Creates a rectangle.
Rectangle_Create :: proc($T: typeid, position: Vector2(T), size: Vector2(T)) -> Rectangle(T) {
    return {position, size}
}

// Cast a rectangle's values to a different type.
Rectangle_Cast :: proc(rectangle: Rectangle($T1), $T2: typeid) -> Rectangle(T2) {
    return {Vector2_Cast(rectangle.position, T2), Vector2_Cast(rectangle.size, T2)}
}

// A basic struct for defining a Circle shape.
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

// A basic dynamic list that can be added to, indexed, and removed from.
List :: struct($T: typeid){
    // The internal Odin dynamic array. Use this for iterating over the list.
    data: [dynamic]T
}

// De-allocate a list.
List_Delete :: proc(list: ^List($T)) {
    delete(list.data)
}

// Adds a value to the end of a list.
List_Add :: proc(list: ^List($T), value: T) {
    append(&list.data, value)
}

// Adds a value to the end of a list.
List_Append_Value :: proc(list: ^List($T), value: T) {
    List_Add(list, value)
}

// Adds a list to the end of a list.
List_Append_List :: proc(list: ^List($T), list2: [dynamic]T) {
    for value in List {
        List_Append_Value(&list.data, value)
    }
}

// Inserts a value into a list at a specific index.
List_Insert :: proc(list: ^List($T), value: T, index: u32) {
    inject_at(&list.data, value, index)
}

// Removes a value from the list at a specific index.
List_Remove :: proc(list: ^List($T), index: u32) {
    ordered_remove(&list.data, index)
}

// Removes a value from the list at a specific index. The list may not stay in the some order afterwards.
List_UnorderedRemove :: proc(list: ^List($T), index: u32) {
    unordered_remove(&list.data, index)
}

// Append something to the end of a list.
List_Append :: proc{
    List_Append_Value,
    List_Append_List,
}

// Add something to the end of a list.
List_PushBack :: proc(list: ^List($T), value: T) {
    List_Add(list, value)
}

// Get the length of a list.
List_Length :: proc(list: ^List($T)) -> u32 {
    return len(list.data)
}

// Set a value in a list at a specific index.
List_Set :: proc(list: ^List($T), index: u32) {
    assign_at(list.data, index)
}

// Get a value in a list at a specific index.
List_At :: proc(list: ^List($T), index: u32) -> T {
    return list.data[index]
}

// Get the value at the beginning of a list.
List_Front :: proc(list: ^List($T), index: u32) -> T {
    return list.data[0]
}

// Get the value at the end of a list.
List_Back :: proc(list: ^List($T), index: u32) -> T {
    return list.data[List_Length(list) - 1]
}

// Get the last value of a list, and remove it from said list.
List_PopBack :: proc(list: ^List($T)) -> T {
    listSize: u32 = List_Length(list)
    result: T = List_At(list, listSize - 1)
    List_Remove(list, listSize - 1)
    return result
}

// Get the first value of a list, and remove it from said list.
List_PopFront :: proc(list: ^List($T)) -> T {
    listSize: u32 = List_Length(list)
    result: T = List_At(list, listSize - 1)
    List_Remove(list, listSize - 1)
    return result
}

// Clear a list of all values.
List_Clear :: proc(list: ^List($T)) {
    clear(list.data)
}

// LIST END

//-NODES BEGIN

// A basic node with no position.
Node :: struct {
    id: u128,

    Step: proc(),
    Draw: proc(),
}

// Create a new node inside an engine.
Node_Create :: proc(engine: ^Engine, stepFunc: proc() = nil, drawFunc: proc() = nil) -> Node {
    result: Node
    result.id = engine.nextIndex
    engine.nextIndex += 1
    result.Step = stepFunc
    result.Draw = drawFunc

    return result
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

// A struct for defining an engine instance.
Engine :: struct {
    nextIndex: u128,
    nodes: List(Node)
}

// Create an engine.
Engine_Create :: proc() -> Engine {
    return Engine{1, {}}
}

/*Engine_Delete :: proc(engine: Engine) {

}*/

// Update the engine for this frame.
Engine_Update :: proc(engine: ^Engine) {
    for &node in engine.nodes.data {
        node.Step()
    }
    Draw_Begin()
    for &node in engine.nodes.data {
        node.Draw()
    }
    Draw_End()
}

// NODES END

// An enum of mouse buttons.
MouseButton :: enum {
    Left,
    Right,
    Middle,
}

// An enum of keys on the keyboard.
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

// Cast a type to a different type
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

@(private)
_windowDefaultSize: Vector2(u32) = Vector2_Create(600,400,u32)

// Initialize the window with a specific size and Title.
Window_Init :: proc(size: Vector2(u32) = _windowDefaultSize, window_title: string) {
    rl.InitWindow(i32(size.x), i32(size.y), strings.clone_to_cstring(window_title))
    _windowSize = size
    _windowTitle = window_title
}

// Is the window still open? (Can be closed by X, Esc, etc.)
Window_IsOpen :: proc() -> bool {
    return !rl.WindowShouldClose()
}

// Close the window.
Window_Close :: proc() {
    rl.CloseWindow()
}

// Checks if the window is fullscreen.
Window_IsFullscreen :: proc() -> bool {
    return rl.IsWindowFullscreen()
}

// Checks if the window is in focus (clicked on).
Window_IsFocused :: proc() -> bool {
    return rl.IsWindowFocused()
}

// Checks if the window is maximized.
Window_IsMaximized :: proc() -> bool {
    return rl.IsWindowMaximized()
}

// Checks if the window is minimized.
Window_IsMinimized :: proc() -> bool {
    return rl.IsWindowMinimized()
}

// Maximizes the window.
Window_Maximize :: proc() {
    rl.MaximizeWindow()
}

Filename_Exists :: proc(filename: string) -> bool {
    return rl.FileExists(strings.clone_to_cstring(filename))
}

Filename_DirectoryExists ::proc(filename: string) -> bool {
    return rl.DirectoryExists(strings.clone_to_cstring(filename))
}

// Minimize the window.
Window_Minimize :: proc() {
    rl.MinimizeWindow()
}

// Checks if the window is hidden.
Window_IsHidden :: proc() -> bool {
    return rl.IsWindowHidden()
}

// Restores the window back onto the screen.
Window_Restore :: proc() {
    rl.RestoreWindow()
}

// Toggles borderless windowed fullscreen mode for the window.
Window_ToggleFullscreen :: proc() {
    rl.ToggleBorderlessWindowed()
}

// Get the position of the window.
Window_GetPosition :: proc() -> Vector2(i32) {
    return RaylibVector2_ToVector2(rl.GetWindowPosition(), i32)
}

// Set the position of the window.
Window_SetPosition :: proc(vector: Vector2(i32)) {
    rl.SetWindowPosition(vector.x, vector.y)
}

@(private)
_windowMinSize: Vector2(i32) = nil

@(private)
_windowMaxSize: Vector2(i32) = nil

Window_GetMinSize :: proc() -> Vector2(i32) {
    return _windowMinSize
}

Wnidow_GetMaxSize :: proc() -> Vector2(i32) {
    return _windowMaxSize
}

Window_SetMinSize :: proc(vector: Vector2(i32)) {
    _windowMinSize = vector
    rl.SetWindowMinSize()
}

Window_SetMaxSize :: proc(vector: Vector2(i32)) {
    _windowMaxSize = vector
}

@(private)
_windowSize: Vector2(u32)

// Get the window size.
Window_GetSize :: proc() -> Vector2(u32) {
    return _windowSize
}

// Set the window size.
Window_SetSize :: proc(size: Vector2(u32)) {
    rl.SetWindowSize(i32(size.x), i32(size.y))
}

// Set the current text stored in the clipboard.
Clipboard_SetText :: proc(text: string) {
    rl.SetClipboardText(strings.clone_to_cstring(text))
}

// Get the current text stored in the clipboard.
Clipboard_GetText :: proc() -> string {
    return string(rl.GetClipboardText())
}

@(private)
_windowTitle: string = ""

// Set the title text of the window.
Window_SetTitle :: proc(title: string) {
    _windowTitle = title
    rl.SetWindowTitle(strings.clone_to_cstring(title))
}

// Get the title text of the window.
Window_GetTitle :: proc() -> string {
    return _windowTitle
}

@(private)
_fpsTarget: u32 = 0

// Set the target framerate.
FPS_SetTarget :: proc(target: u32) {
    rl.SetTargetFPS(i32(target))
    _fpsTarget = target
}

// Get the target framerate.
FPS_GetTarget :: proc() -> u32 {
    return _fpsTarget
}

// Get the current framerate that the window is running at.
FPS_Get :: proc() -> u32 {
    return u32(rl.GetFPS())
}

// Sleep the computer for the specified number of seconds.
Sleep :: proc(seconds: f32) {
    rl.WaitTime(f64(seconds))
}

// Used to begin the drawing phase of a frame.
Draw_Begin :: proc() {
    rl.BeginDrawing()
}

// Used to end the drawing phase of a frame.
Draw_End :: proc() {
    rl.EndDrawing()
}

// Activate the clipping rendering mode.
Clipping_Begin :: proc(rectangle: Rectangle($T)) {
    rl.BeginScissorMode(rectangle.position.x, rectangle.position.y, rectangle.size.x, rectangle.size.y)
}

// Finish the clipping rendering mode.
Clipping_End :: proc() {
    rl.EndScissorMode()
}

// Get the length of time that it took to draw the last frame in seconds.
Delta_Get :: proc() -> f32 {
    return rl.GetFrameTime()
}

// Clears the entire screen with a single color.
Color_DrawClear :: proc(color: Color) {
    rl.ClearBackground(Color_ToRaylibColor(color))
}

// Draw a filled rectangle with a given color.
Rectangle_Draw :: proc(rectangle: Rectangle($T), color: Color) {
    rl.DrawRectangleV(Vector2_ToRaylibVector2(rectangle.position), Vector2_ToRaylibVector2(rectangle.size), Color_ToRaylibColor(color))
}

// Draw a lined rectangle with a given color and thickness.
Rectangle_DrawLines :: proc(rectangle: Rectangle($T), color: Color, thickness: f32) {
    rl.DrawRectangleLinesEx(Rectangle_ToRaylibRectangle(rectangle), thickness, Color_ToRaylibColor(color))
}

// Draw a line with a given color and thickness.
Line_Draw :: proc(startPos: Vector2($T), endPos: Vector2(T), color: Color, thickness: f32 = 1) {
    rl.DrawLineEx(Vector2_ToRaylibVector2(startPos), Vector2_ToRaylibVector2(endPos), thickness, Color_ToRaylibColor(color))
}

// Draw a filled circle with a given color.
Circle_Draw :: proc(circle: Circle($T), color: Color) {
    rl.DrawCircleV(Vector2_ToRaylibVector2(circle.position), circle.radius, Color_ToRaylibColor(color))
}

// Draw a lined circle with a given color and thickness.
Circle_DrawLines :: proc(circle: Circle($T), color: Color, thickness: f32 = 1) {
    rl.DrawCircleLinesV(Vector2_ToRaylibVector2(circle.position), circle.radius, color)
}

// Draw a texture at a given postion and color tint.
Texture_Draw :: proc(texture: Texture, position: Vector2($T), color: Color) {
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

// Check if the cursor is overtop the window.
Cursor_IsOnscreen :: proc() -> bool {
    return rl.IsCursorOnScreen()
}

// Show the cursor onscreen.
Cursor_Show :: proc() {
    rl.ShowCursor()
}

// Hide the cursor onscreen.
Cursor_Hide :: proc() {
    rl.HideCursor()
}

// Freeze the cursor.
Cursor_Lock :: proc() {
    rl.DisableCursor()
}

// Unfreeze the cursor.
Cursor_Unlock :: proc() {
    rl.EnableCursor()
}

// Checks if the specified mouse button is held down.
Mouse_IsHeld :: proc(button: MouseButton) -> bool {
    if rlbutton, ok := MouseButton_ToRaylibMouseButton(button); ok {
        return rl.IsMouseButtonDown(rlbutton)
    }

    return false
}

// Checks if the specified mouse button has just been pressed this frame.
Mouse_IsPressed :: proc(button: MouseButton) -> bool {
    if rlbutton, ok := MouseButton_ToRaylibMouseButton(button); ok {
        return rl.IsMouseButtonPressed(rlbutton)
    }

    return false
}

// Checks if the specified mouse button has just been released this frame.
Mouse_IsReleased :: proc(button: MouseButton) -> bool {
    if rlbutton, ok := MouseButton_ToRaylibMouseButton(button); ok {
        return rl.IsMouseButtonReleased(rlbutton)
    }

    return false
}

Screenshot_Save :: proc(filename: string) {
    rl.TakeScreenshot(strings.clone_to_cstring(filename))
}

URL_Open :: proc(url: string) {
    rl.OpenURL(strings.clone_to_cstring(url))
}


// TODO: Random

// BACKEND WRAPPER FUNCTIONS END

// Checks if an input is held down.
Input_IsHeld :: proc{
    Key_IsHeld,
    Mouse_IsHeld,
}

// Checks if an input has just been pressed this frame.
Input_IsPressed :: proc{
    Key_IsPressed,
    Mouse_IsPressed,
}

// Checks if an input has just been released this frame.
Input_IsReleased :: proc{
    Key_IsReleased,
    Mouse_IsReleased,
}

// Draw something to the screen.
Draw :: proc{
    Rectangle_Draw,
    Circle_Draw,
    Texture_Draw,
}

// Draw something to the screen with lines instead of as a filled shape.
DrawLines :: proc{
    Rectangle_DrawLines,
    Circle_DrawLines,
}