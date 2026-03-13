#!/bin/bash
set -e

# This needs to be updated to handle the new CMAKE for each target. Should be updated once linux build target had been added to the project.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION=$(cat "$SCRIPT_DIR/../service-versions.json" | python3 -c "import sys,json; print(json.load(sys.stdin)['tiler'])")

OUTPUT_DIR="$SCRIPT_DIR/../services/tiler"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

URL="https://github.com/NTNUFrokostklubben/skavl-tiler/releases/download/$VERSION/server-$VERSION-linux.tar.gz"

echo "Downloading tiler $VERSION..."
curl -L "$URL" -o /tmp/tiler-linux.tar.gz
tar -xzf /tmp/tiler-linux.tar.gz -C "$OUTPUT_DIR"
rm /tmp/tiler-linux.tar.gz

echo "Done. Tiler extracted to $OUTPUT_DIR"