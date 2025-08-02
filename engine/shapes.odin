package engine

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