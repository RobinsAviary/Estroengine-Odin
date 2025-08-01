# Estroengine
A portable easy-to-use node-based game engine, built on [raylib](https://www.raylib.com/) in [Odin](https://odin-lang.org/).

## A Note On Portability
Estroengine is designed in such a way to be a dynamic and simple graphics library, with some data types attached. As such, projects made with Estroengine are technically capable of using multiple different underlying frameworks, allowng for effectively endless portability. That being said, the current version just uses [raylib](https://www.raylib.com/) to fill in all the implementations, but I hope for this to change more in the future.

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

Estroengine is almost entirely documented.

Odin includes a built-in tool to generate this documentation. There is a ``docs.bat`` file for easily exporting everything to a ``docs.txt`` file. You can also access this by using ``odin docs`` in the command line with a folder (or ``.`` for the current directory).

You can also view this documentation while writing code by using [OLS](https://github.com/DanielGavin/ols). If you're adding the library as a collection (``estro:engine`` as opposed to ``engine``) you'll need to add it to the ``ols.json`` file for your project (see [here](https://github.com/DanielGavin/ols?tab=readme-ov-file#configuration)). Otherwise it will link automatically.

## Project Template
If you want to get up-and-running with Estroengine quickly, all you need to do is [install Odin](https://odin-lang.org/docs/install/) and download [this repo](https://github.com/RobinsAviary/Estroengine-Template-Odin). The rest of the details for how to use it are over there.

Otherwise, see below for the instructions to build this engine with your project.

## Building
All you really need to do to get the engine connected to your project is to include it via ``import "engine"``.

If you want to attach it in such a way that matches the repo name (my preferred way) you can build/run the project with the added parameter ``-collection:estro=<SourceCodeFolderName>`` and then include it via ``import "estro:engine"``. I personally use ``import e "estro:engine"`` so that you can easily access the namespace using ``e.<Function/VariableName>``.
