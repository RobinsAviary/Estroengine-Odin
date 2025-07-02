# Estroengine
An experimental port of [Estroengine](https://github.com/RobinsAviary/Estroengine), an easy-to-use node-based game engine, to [Odin](https://odin-lang.org/).

## Building
All you really need to do to get the engine connected to your project is to include it via ``import "engine"``.

If you want to attach it in such a way that matches the repo name (my preferred way) you can build/run the project with the added parameter ``-collection:estro=<SourceCodeFolderName>`` and then include it via ``import "estro:engine"``. I personally use ``import e "estro:engine"`` so that you can easily access the namespace using ``e.<Function/VariableName>``.

## Example
    package main
    
    import e "estro:engine"
    
    main :: proc() {
        TestDraw :: proc() {
            position: e.Vector2(i32) = e.Cursor_GetPosition()
            if (e.Cursor_IsOnscreen()) {
                e.Circle_Draw(e.Circle_Create(f32, e.Cast(position, f32), 16), e.Estrogen)
            }
        }
    
        engine: e.Engine = e.Engine_Create()
    
        testNode: e.Node = e.Node_Create(&engine, nil, TestDraw)
    
        e.List_Add(&engine.nodes, testNode)
    
        e.Window_Init({600, 400}, "Title")
    
        for (e.Window_IsOpen()) {
            e.Color_DrawClear(e.White)
            e.Engine_Update(&engine)
        }
    }

## Docs
Odin includes a built-in tool to generate documentation. There is a ``.bat`` file for easily exporting everything to a ``.txt`` file. You can also access this by using ``odin docs`` in the command line with a folder (or ``.`` for the current directory).
