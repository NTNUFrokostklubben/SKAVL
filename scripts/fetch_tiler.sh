#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION=$(cat "$SCRIPT_DIR/../service-versions.json" | python3 -c "import sys,json; print(json.load(sys.stdin)['tiler'])")
MARKER="$VERSION-linux"

OUTPUT_DIR="$SCRIPT_DIR/../services/tiler"
VERSION_MARKER="$OUTPUT_DIR/.version"

BUILD_DIRS=(
    "$SCRIPT_DIR/../build/linux/x64/debug/bundle/services/tiler"
    "$SCRIPT_DIR/../build/linux/x64/profile/bundle/services/tiler"
    "$SCRIPT_DIR/../build/linux/x64/release/bundle/services/tiler"
)

# Check if already up to date
if [ -f "$VERSION_MARKER" ]; then
    INSTALLED_MARKER=$(cat "$VERSION_MARKER")
    if [ "$INSTALLED_MARKER" = "$MARKER" ]; then
        echo "Tiler $VERSION (linux) already up to date."
        exit 0
    fi
fi

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

URL="https://github.com/NTNUFrokostklubben/skavl-tiler/releases/download/$VERSION/server-$VERSION-linux.tar.gz"

echo "Downloading tiler $VERSION (linux)..."
curl -L "$URL" -o /tmp/tiler-linux.tar.gz
tar -xzf /tmp/tiler-linux.tar.gz -C "$OUTPUT_DIR"
rm /tmp/tiler-linux.tar.gz

echo "$MARKER" > "$VERSION_MARKER"

for BUILD_DIR in "${BUILD_DIRS[@]}"; do
    if [ -d "$BUILD_DIR" ]; then
        echo "Removing outdated build output: $BUILD_DIR"
        rm -rf "$BUILD_DIR"
    fi
done

echo "Done. Tiler $VERSION (linux) ready."