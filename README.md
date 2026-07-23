# TerrainGen for macOS (alpha)

This fork is preparing a native macOS build of Nicholas Chapman's
[TerrainGen](https://github.com/Ono-Sendai/terraingen). It keeps the original
OpenCL erosion simulation and OpenGL renderer while adding the macOS-specific
CGL sharing path, OpenGL 4.1 setup, app packaging, and native file panels.

> **Current status:** the alpha has launched successfully on a physical Apple
> Silicon Mac and GitHub Actions verifies each build and ad-hoc app signature.
> It is not yet a notarized release; continue using the smoke-test checklist in
> [building.md](building.md).

Build locally with:

```bash
brew install cmake ninja sdl2 jpeg-turbo
bash macos/build.sh
open build-macos/TerrainGen.app
```

### Import Victorian elevation data

TerrainGen can import floating-point
[ESRI ASCII Grid](https://desktop.arcgis.com/en/arcmap/latest/manage-data/raster-and-images/esri-ascii-raster-format.htm)
(`.asc`) elevation files:

1. Pause the simulation.
2. Select **Import elevation grid (.asc)**.
3. Choose a cropped DEM file. TerrainGen resizes the simulation to the file,
   uses the DEM cell size in metres, preserves elevation values in metres, and
   pauses before erosion begins.

The importer accepts up to 4,194,304 cells, with a maximum width or height of
4,096 cells. Crop or resample larger statewide products first. `NODATA_value`
cells are filled with the lowest valid elevation because TerrainGen's
simulation grid cannot contain missing cells.

You can also open a DEM from Terminal:

```bash
open build-macos/TerrainGen.app --args --dem "/path/to/elevation.asc"
```

Useful official sources:

- [Vicmap Elevation 10m DEM](https://discover.data.vic.gov.au/dataset/vicmap-elevation-dem-10m)
  is Victoria's statewide, hydrologically enforced 10 m terrain product.
- The Victorian Government's
  [3D regional towns LiDAR project](https://www.land.vic.gov.au/maps-and-spatial/imagery/elevation-data/major-lidar-projects/3d-regional-towns-lidar-2018-19)
  provides open 1 m DEMs in ESRI ASCII format. Its official
  [Wangaratta sample](https://cip-data-samples.s3.ap-southeast-2.amazonaws.com/elevation/projects/2018-19_3d-regional-towns_lidar/2018-19_3d-regional-towns_sample.zip)
  is ready to test, although the download is about 436 MiB.

Data remains subject to its source licence. Attribute Vicmap 10m-derived work
as: © State of Victoria (Department of Transport and Planning), provided under
the Creative Commons Attribution 4.0 International Licence.

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
