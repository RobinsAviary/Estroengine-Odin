package engine

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

echo :: proc() {
    fmt.println("Hello, Robin!")
}

Vector2 :: struct($T: typeid) {
    x: T,
    y: T,
}

Vector2_add :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x + vec2.x, vec1.y + vec2.y}
}

Vector2_subtract :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x - vec2.x, vec1.y - vec2.y}
} 

Vector2_multiply :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x * vec2.x, vec1.y * vec2.y}
}

Vector2_divide :: proc(vec1: Vector2($T), vec2: Vector2(T)) -> Vector2(T) {
    return {vec1.x / vec2.x, vec1.y / vec2.y}
}

add :: proc {
    Vector2_add,
    Vector3_add,
}

subtract :: proc {
    Vector2_subtract,
    Vector3_subtract,
}

multiply :: proc {
    Vector2_multiply,
    Vector3_multiply,
}

divide :: proc {
    Vector2_divide,
    Vector3_divide,
}

Vector3 :: struct($T: typeid) {
    x: T,
    y: T,
    z: T,
}

Vector3_add :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x + vec2.x, vec1.y + vec2.y, vec1.z + vec2.z}
}

Vector3_subtract :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x - vec2.x, vec1.y - vec2.y, vec1.z - vec2.z}
}

Vector3_multiply :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x * vec2.x, vec1.y * vec2.y, vec1.z * vec2.z}
}

Vector3_divide :: proc(vec1: Vector3($T), vec2: Vector3(T)) -> Vector3(T) {
    return {vec1.x / vec2.x, vec1.y / vec2.y, vec1.z / vec2.z}
}

Color :: struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
}

// Values are from 0.0-1.0
Color_HSV :: proc(hue: f32, saturation: f32, value: f32) -> Color {
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

Color_HSVA :: proc(hue: f32, saturation: f32, value: f32, alpha: u8) -> Color {
    result: Color

    result = Color_HSV(hue, saturation, value)

    result.a = alpha

    return result
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

// BACKEND WRAPPER FUNCTIONS

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

ClearColor :: proc() {

}

// END BACKEND WRAPPER FUNCTIONS