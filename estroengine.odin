package engine

import "core:fmt"

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
}

subtract :: proc {
    Vector2_subtract,
}

multiply :: proc {
    Vector2_multiply,
}

divide :: proc {
    Vector2_divide
}