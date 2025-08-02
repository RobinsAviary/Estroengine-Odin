package engine
import rl "vendor:raylib"
import "core:strings"

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