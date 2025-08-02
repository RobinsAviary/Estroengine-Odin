package engine

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

// PROCESS GROUPS END