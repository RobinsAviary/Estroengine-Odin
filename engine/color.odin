package engine

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