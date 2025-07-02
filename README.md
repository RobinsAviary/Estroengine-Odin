# Estroengine
An experimental port of [Estroengine](https://github.com/RobinsAviary/Estroengine) to [Odin](https://odin-lang.org/).

## Building
All you really need to do to get the engine connected to your project is to include it via ``import "engine"``.

If you want to attach it in such a way that matches the repo name (my preferred way) you can build/run the project with the added parameter ``-collection:estro=<SourceCodeFolderName>`` and then include it via ``import "estro:engine"``. I personally use ``import e "estro:engine"`` so that you can easily access the namespace using ``e.<Function/ParameterName>``.
