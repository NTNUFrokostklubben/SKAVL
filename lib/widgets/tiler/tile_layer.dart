import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skavl/proto/tiler.pb.dart';

/// Renders a tile manifest by using READY tiles in world space
///
/// TODO(#85 adapter): replace direct dependency on ViewportTileManifest
/// Currently this class is heavily coupled to the proto DTO so an adapter should be made in the future.
class TileLayer extends StatelessWidget {
  const TileLayer({
    super.key,
    required this.panelWidthPx,
    required this.panelHeightPx,
    required this.tileSizePx,
    required this.tiles,
    required this.originX,
    required this.originY,
    this.previousTiles = const [],
    this.previousTileSizePx,
  });

  // Preplanning based on image source
  final double panelWidthPx;
  final double panelHeightPx;

  // Tile placement
  final double tileSizePx;
  final double originX;
  final double originY;
  final Iterable<TileRef> tiles;

  // Tilecache to remove flashing
  final Iterable<TileRef> previousTiles;
  final double? previousTileSizePx;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: panelWidthPx,
        height: panelHeightPx,
        child: Stack(
          children: [
            // Display previous tiles until new tiles are ready to reduce flash
            for (final tile in previousTiles)
              if (tile.state == TileState.TILE_STATE_READY &&
                  tile.localPath.isNotEmpty)
                Positioned(
                  key: ValueKey(
                    "prev_${tile.localPath}_${tile.coord.level}_${tile.coord.x}_${tile.coord.y}",
                  ),
                  left: tile.coord.x * (previousTileSizePx ?? tileSizePx),
                  top: tile.coord.y * (previousTileSizePx ?? tileSizePx),
                  width: previousTileSizePx ?? tileSizePx,
                  height: previousTileSizePx ?? tileSizePx,
                  child: Image.file(
                    File(tile.localPath),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.none,
                    gaplessPlayback: true,
                  ),
                ),

            // Display current tiles
            for (final tile in tiles)
              if (tile.state == TileState.TILE_STATE_READY &&
                  (tile.localPath).isNotEmpty)
                Positioned(
                  key: ValueKey(
                    "${tile.localPath}_${tile.coord.level}_${tile.coord.x}_${tile.coord.y}",
                  ),
                  left: (tile.coord.x) * tileSizePx,
                  top: (tile.coord.y) * tileSizePx,
                  width: tileSizePx,
                  height: tileSizePx,
                  child: Image.file(
                    File(tile.localPath),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.none,
                    gaplessPlayback: true,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
