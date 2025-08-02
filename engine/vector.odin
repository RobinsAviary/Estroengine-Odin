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