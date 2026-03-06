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
  });

  final double panelWidthPx;
  final double panelHeightPx;
  final double tileSizePx;
  final double originX;
  final double originY;

  final Iterable<TileRef> tiles;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: panelWidthPx,
        height: panelHeightPx,
        child: Stack(
          children: [
            for (final tile in tiles)
              if (tile.state == TileState.TILE_STATE_READY &&
                  (tile.localPath).isNotEmpty)
                Positioned(
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
