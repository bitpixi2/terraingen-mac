#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEPS_DIR="${TERRAINGEN_DEPS_DIR:-$REPO_ROOT/.deps}"
BUILD_DIR="${TERRAINGEN_BUILD_DIR:-$REPO_ROOT/build-macos}"
GLARE_DIR="$DEPS_DIR/glare-core"
GLARE_COMMIT="99a1550a062c61f03d015012bc217369178d378e"
GLARE_PATCH="$SCRIPT_DIR/glare-core-macos.patch"

for command_name in brew cmake ninja git; do
	if ! command -v "$command_name" >/dev/null 2>&1; then
		echo "Missing required command: $command_name" >&2
		exit 1
	fi
done

mkdir -p "$DEPS_DIR"

if [[ ! -d "$GLARE_DIR/.git" ]]; then
	git clone https://github.com/glaretechnologies/glare-core.git "$GLARE_DIR"
	git -C "$GLARE_DIR" checkout --detach "$GLARE_COMMIT"
else
	current_commit="$(git -C "$GLARE_DIR" rev-parse HEAD)"
	if [[ "$current_commit" != "$GLARE_COMMIT" ]]; then
		echo "Existing Glare Core checkout is at $current_commit" >&2
		echo "Expected the pinned revision $GLARE_COMMIT" >&2
		echo "Move $GLARE_DIR aside or set TERRAINGEN_DEPS_DIR to a clean directory." >&2
		exit 1
	fi
fi

if git -C "$GLARE_DIR" apply --check "$GLARE_PATCH"; then
	git -C "$GLARE_DIR" apply "$GLARE_PATCH"
elif git -C "$GLARE_DIR" apply --reverse --check "$GLARE_PATCH"; then
	echo "Glare Core macOS patch is already applied."
else
	echo "Glare Core macOS patch does not apply cleanly to $GLARE_COMMIT." >&2
	exit 1
fi

SDL_PREFIX="$(brew --prefix sdl2)"
JPEG_PREFIX="$(brew --prefix jpeg-turbo)"
CMAKE_PREFIX_PATH="$SDL_PREFIX;$JPEG_PREFIX"

cmake -S "$REPO_ROOT" -B "$BUILD_DIR" -G Ninja \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
	-DCMAKE_PREFIX_PATH="$CMAKE_PREFIX_PATH" \
	-DGLARE_CORE_TRUNK="$GLARE_DIR"

cmake --build "$BUILD_DIR" --parallel

echo
echo "Built: $BUILD_DIR/TerrainGen.app"
echo "Run:   $BUILD_DIR/TerrainGen.app/Contents/MacOS/TerrainGen"
