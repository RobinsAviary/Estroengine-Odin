package engine

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