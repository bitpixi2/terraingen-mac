# TerrainGen for macOS (alpha)

This fork is preparing a native macOS build of Nicholas Chapman's
[TerrainGen](https://github.com/Ono-Sendai/terraingen). It keeps the original
OpenCL erosion simulation and OpenGL renderer while adding the macOS-specific
CGL sharing path, OpenGL 4.1 setup, app packaging, and native file panels.

> **Current status:** source port under active verification. GitHub Actions
> verifies that the app compiles on an Apple Silicon macOS runner, but a
> successful CI build is not the same as a GPU/runtime test. Do not describe the
> app as a finished or notarized release until the smoke-test checklist in
> [building.md](building.md) passes on a real Mac.

Build locally with:

```bash
brew install cmake ninja sdl2 jpeg-turbo
bash macos/build.sh
open build-macos/TerrainGen.app
```

The first milestone is a stable Mac build. Importing an Australian DEM or other
real elevation data is the next, separate feature; the current UI starts from
procedural terrain.

---

## Original TerrainGen project
TerrainGen is an open source terrain generator and erosion simulator.  
It's GPU powered so runs pretty fast.

Currently I've only made a build for Windows but I would consider making a build for Mac if requested.

You can download the Windows build here: https://github.com/Ono-Sendai/terraingen/releases

![terraingen](https://github.com/user-attachments/assets/35a1109e-c927-4be1-8249-8990135e40d8)

[![Watch vid on YouTube](https://github.com/user-attachments/assets/c1c95efb-b4c3-43d7-bff1-bcb8c4c55d84)](https://www.youtube.com/watch?v=qBPaR19crXY "Watch vid on YouTube")

![Gh5rGZTaUAAKiv4](https://github.com/user-attachments/assets/c7722701-1fd5-4941-bfe9-485eb598271c)

![t2](https://github.com/Ono-Sendai/terraingen/assets/30285/6fd2c8ab-076b-4198-bc92-584d376f690d)

![Gh5h2g0aYAENYcH](https://github.com/user-attachments/assets/fec869f4-285c-417f-bee8-2e5a7c2b7671)

![t3](https://github.com/Ono-Sendai/terraingen/assets/30285/c774ee56-17a9-4425-a161-1eebf1f32c91)

![t4](https://github.com/Ono-Sendai/terraingen/assets/30285/344b9f00-c14a-46db-9d10-08f6e2116db7)

![t1](https://github.com/Ono-Sendai/terraingen/assets/30285/8f2d0c12-238d-41c4-8f07-2db01aac859c)

[Compiling/Building TerrainGen instructions](building.md)

[Erosion Maths](erosion_maths.md)

[Reading and Related Work](reading.md)
