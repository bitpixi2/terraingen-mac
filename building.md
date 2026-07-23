# Building TerrainGen

## macOS alpha

### Requirements

- macOS 11 or newer
- Xcode Command Line Tools
- Homebrew
- An Apple Silicon or Intel Mac with an OpenCL-capable GPU

Install the tools and libraries:

```bash
xcode-select --install
brew install cmake ninja sdl2 jpeg-turbo
```

### One-command build

From the TerrainGen repository root:

```bash
bash macos/build.sh
```

The script:

1. clones the inspected Glare Core revision into `.deps/glare-core`;
2. applies `macos/glare-core-macos.patch`;
3. locates Homebrew SDL2 and libjpeg-turbo;
4. configures a Release app bundle with CMake and Ninja; and
5. builds `build-macos/TerrainGen.app`.

The Glare Core revision is pinned in the script so a future upstream change
cannot silently alter the build.

Run from Terminal first so startup errors remain visible:

```bash
build-macos/TerrainGen.app/Contents/MacOS/TerrainGen
```

Or open it normally:

```bash
open build-macos/TerrainGen.app
```

### Manual build

If Glare Core is already cloned:

```bash
git -C /path/to/glare-core checkout 99a1550a062c61f03d015012bc217369178d378e
git -C /path/to/glare-core apply --ignore-space-change macos/glare-core-macos.patch

CMAKE_PREFIX_PATH="$(brew --prefix sdl2);$(brew --prefix jpeg-turbo)"

cmake -S . -B build-macos -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
  -DCMAKE_PREFIX_PATH="$CMAKE_PREFIX_PATH" \
  -DGLARE_CORE_TRUNK=/path/to/glare-core

cmake --build build-macos --parallel
```

### Runtime smoke test

A CI build checks compilation and packaging only. Before making a release,
verify all of the following on a physical Mac:

1. TerrainGen opens without an OpenGL or OpenCL context error.
2. The initial terrain appears and changes when the simulation runs.
3. Reset works at the default 1024 x 1024 size.
4. Save/load parameter buttons open native macOS panels.
5. A 16-bit PNG heightfield saves and opens correctly.
6. An EXR heightfield saves and opens correctly.
7. The colour texture saves as PNG.
8. Activity Monitor shows expected GPU use while the simulation runs.

Start with 1024 x 1024. Larger maps can consume substantial unified memory.

### Signing and notarization

The build is an unsigned local app. Distribution outside your own Mac requires
an Apple Developer ID certificate and notarization. Do not remove quarantine
attributes as a substitute for signing.

```bash
codesign --force --deep --options runtime \
  --sign "Developer ID Application: YOUR NAME (TEAMID)" \
  build-macos/TerrainGen.app

codesign --verify --deep --strict --verbose=2 build-macos/TerrainGen.app
spctl --assess --type execute --verbose=4 build-macos/TerrainGen.app
```

Apple deprecated OpenGL and OpenCL in macOS 10.14. They remain available for
compatibility, but a long-term port should migrate rendering and compute to
Metal.

## Original Windows build

The upstream Windows instructions require Ruby, a locally built SDL2, Glare
Core, and libjpeg-turbo.

```text
git clone https://github.com/Ono-Sendai/terraingen.git C:/code/terraingen
git clone https://github.com/glaretechnologies/glare-core.git C:/code/glare-core
```

Set `GLARE_CORE_LIBS`, build libjpeg-turbo from Glare Core's `scripts`
directory, then configure TerrainGen with the Glare Core and SDL build paths.
See the upstream repository for the original Windows release process.
