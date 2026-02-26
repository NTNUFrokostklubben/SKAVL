import 'package:skavl/proto/tiler.pb.dart';

/// Adapter-layer per-panel state for tiled rendering
///
/// sourcePath: local path used to register/describe source (eg. C:\tilecache)
/// sourceId: identified assigned by tiler for future calls to same tile
/// manifest: last viewport plan returned by tiler service.
class PanelState {
  PanelState({required this.sourcePath});
  final String sourcePath;
  String? sourceId;
  ViewportTileManifest? manifest;
}