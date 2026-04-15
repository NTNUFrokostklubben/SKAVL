// This is a generated file - do not edit.
//
// Generated from tiler.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use tileStateDescriptor instead')
const TileState$json = {
  '1': 'TileState',
  '2': [
    {'1': 'TILE_STATE_UNSPECIFIED', '2': 0},
    {'1': 'TILE_STATE_READY', '2': 1},
    {'1': 'TILE_STATE_QUEUED', '2': 2},
    {'1': 'TILE_STATE_GENERATING', '2': 3},
    {'1': 'TILE_STATE_MISSING', '2': 4},
    {'1': 'TILE_STATE_FAILED', '2': 5},
  ],
};

/// Descriptor for `TileState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tileStateDescriptor = $convert.base64Decode(
    'CglUaWxlU3RhdGUSGgoWVElMRV9TVEFURV9VTlNQRUNJRklFRBAAEhQKEFRJTEVfU1RBVEVfUk'
    'VBRFkQARIVChFUSUxFX1NUQVRFX1FVRVVFRBACEhkKFVRJTEVfU1RBVEVfR0VORVJBVElORxAD'
    'EhYKElRJTEVfU1RBVEVfTUlTU0lORxAEEhUKEVRJTEVfU1RBVEVfRkFJTEVEEAU=');

@$core.Deprecated('Use tileCoordDescriptor instead')
const TileCoord$json = {
  '1': 'TileCoord',
  '2': [
    {'1': 'level', '3': 1, '4': 1, '5': 13, '10': 'level'},
    {'1': 'x', '3': 2, '4': 1, '5': 13, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 13, '10': 'y'},
  ],
};

/// Descriptor for `TileCoord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tileCoordDescriptor = $convert.base64Decode(
    'CglUaWxlQ29vcmQSFAoFbGV2ZWwYASABKA1SBWxldmVsEgwKAXgYAiABKA1SAXgSDAoBeRgDIA'
    'EoDVIBeQ==');

@$core.Deprecated('Use tileRefDescriptor instead')
const TileRef$json = {
  '1': 'TileRef',
  '2': [
    {
      '1': 'coord',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.tiler.v1.TileCoord',
      '10': 'coord'
    },
    {
      '1': 'state',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.skavl.tiler.v1.TileState',
      '10': 'state'
    },
    {'1': 'local_path', '3': 3, '4': 1, '5': 9, '10': 'localPath'},
    {'1': 'is_prefetch', '3': 4, '4': 1, '5': 8, '10': 'isPrefetch'},
  ],
};

/// Descriptor for `TileRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tileRefDescriptor = $convert.base64Decode(
    'CgdUaWxlUmVmEi8KBWNvb3JkGAEgASgLMhkuc2thdmwudGlsZXIudjEuVGlsZUNvb3JkUgVjb2'
    '9yZBIvCgVzdGF0ZRgCIAEoDjIZLnNrYXZsLnRpbGVyLnYxLlRpbGVTdGF0ZVIFc3RhdGUSHQoK'
    'bG9jYWxfcGF0aBgDIAEoCVIJbG9jYWxQYXRoEh8KC2lzX3ByZWZldGNoGAQgASgIUgppc1ByZW'
    'ZldGNo');

@$core.Deprecated('Use viewportTileManifestDescriptor instead')
const ViewportTileManifest$json = {
  '1': 'ViewportTileManifest',
  '2': [
    {'1': 'source_id', '3': 1, '4': 1, '5': 9, '10': 'sourceId'},
    {'1': 'selected_level', '3': 2, '4': 1, '5': 13, '10': 'selectedLevel'},
    {
      '1': 'tiles',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.skavl.tiler.v1.TileRef',
      '10': 'tiles'
    },
  ],
};

/// Descriptor for `ViewportTileManifest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewportTileManifestDescriptor = $convert.base64Decode(
    'ChRWaWV3cG9ydFRpbGVNYW5pZmVzdBIbCglzb3VyY2VfaWQYASABKAlSCHNvdXJjZUlkEiUKDn'
    'NlbGVjdGVkX2xldmVsGAIgASgNUg1zZWxlY3RlZExldmVsEi0KBXRpbGVzGAMgAygLMhcuc2th'
    'dmwudGlsZXIudjEuVGlsZVJlZlIFdGlsZXM=');

@$core.Deprecated('Use sourceRefDescriptor instead')
const SourceRef$json = {
  '1': 'SourceRef',
  '2': [
    {'1': 'source_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'sourceId'},
    {'1': 'source_path', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'sourcePath'},
  ],
  '8': [
    {'1': 'ref'},
  ],
};

/// Descriptor for `SourceRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceRefDescriptor = $convert.base64Decode(
    'CglTb3VyY2VSZWYSHQoJc291cmNlX2lkGAEgASgJSABSCHNvdXJjZUlkEiEKC3NvdXJjZV9wYX'
    'RoGAIgASgJSABSCnNvdXJjZVBhdGhCBQoDcmVm');

@$core.Deprecated('Use rectPxDescriptor instead')
const RectPx$json = {
  '1': 'RectPx',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 3, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 3, '10': 'y'},
    {'1': 'width', '3': 3, '4': 1, '5': 13, '10': 'width'},
    {'1': 'height', '3': 4, '4': 1, '5': 13, '10': 'height'},
  ],
};

/// Descriptor for `RectPx`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rectPxDescriptor = $convert.base64Decode(
    'CgZSZWN0UHgSDAoBeBgBIAEoA1IBeBIMCgF5GAIgASgDUgF5EhQKBXdpZHRoGAMgASgNUgV3aW'
    'R0aBIWCgZoZWlnaHQYBCABKA1SBmhlaWdodA==');

@$core.Deprecated('Use tilesetDescriptorDescriptor instead')
const TilesetDescriptor$json = {
  '1': 'TilesetDescriptor',
  '2': [
    {'1': 'source_id', '3': 1, '4': 1, '5': 9, '10': 'sourceId'},
    {'1': 'source_width_px', '3': 2, '4': 1, '5': 13, '10': 'sourceWidthPx'},
    {'1': 'source_height_px', '3': 3, '4': 1, '5': 13, '10': 'sourceHeightPx'},
    {'1': 'tile_width_px', '3': 4, '4': 1, '5': 13, '10': 'tileWidthPx'},
    {'1': 'tile_height_px', '3': 5, '4': 1, '5': 13, '10': 'tileHeightPx'},
    {'1': 'min_level', '3': 6, '4': 1, '5': 13, '10': 'minLevel'},
    {'1': 'max_level', '3': 7, '4': 1, '5': 13, '10': 'maxLevel'},
  ],
};

/// Descriptor for `TilesetDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tilesetDescriptorDescriptor = $convert.base64Decode(
    'ChFUaWxlc2V0RGVzY3JpcHRvchIbCglzb3VyY2VfaWQYASABKAlSCHNvdXJjZUlkEiYKD3NvdX'
    'JjZV93aWR0aF9weBgCIAEoDVINc291cmNlV2lkdGhQeBIoChBzb3VyY2VfaGVpZ2h0X3B4GAMg'
    'ASgNUg5zb3VyY2VIZWlnaHRQeBIiCg10aWxlX3dpZHRoX3B4GAQgASgNUgt0aWxlV2lkdGhQeB'
    'IkCg50aWxlX2hlaWdodF9weBgFIAEoDVIMdGlsZUhlaWdodFB4EhsKCW1pbl9sZXZlbBgGIAEo'
    'DVIIbWluTGV2ZWwSGwoJbWF4X2xldmVsGAcgASgNUghtYXhMZXZlbA==');

@$core.Deprecated('Use describeSourceRequestDescriptor instead')
const DescribeSourceRequest$json = {
  '1': 'DescribeSourceRequest',
  '2': [
    {
      '1': 'source',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.tiler.v1.SourceRef',
      '10': 'source'
    },
  ],
};

/// Descriptor for `DescribeSourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List describeSourceRequestDescriptor = $convert.base64Decode(
    'ChVEZXNjcmliZVNvdXJjZVJlcXVlc3QSMQoGc291cmNlGAEgASgLMhkuc2thdmwudGlsZXIudj'
    'EuU291cmNlUmVmUgZzb3VyY2U=');

@$core.Deprecated('Use describeSourceResponseDescriptor instead')
const DescribeSourceResponse$json = {
  '1': 'DescribeSourceResponse',
  '2': [
    {
      '1': 'descriptor',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.tiler.v1.TilesetDescriptor',
      '10': 'descriptor'
    },
  ],
};

/// Descriptor for `DescribeSourceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List describeSourceResponseDescriptor =
    $convert.base64Decode(
        'ChZEZXNjcmliZVNvdXJjZVJlc3BvbnNlEkEKCmRlc2NyaXB0b3IYASABKAsyIS5za2F2bC50aW'
        'xlci52MS5UaWxlc2V0RGVzY3JpcHRvclIKZGVzY3JpcHRvcg==');

@$core.Deprecated('Use planViewportRequestDescriptor instead')
const PlanViewportRequest$json = {
  '1': 'PlanViewportRequest',
  '2': [
    {
      '1': 'source',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.tiler.v1.SourceRef',
      '10': 'source'
    },
    {
      '1': 'viewport_source_rect_px',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.skavl.tiler.v1.RectPx',
      '10': 'viewportSourceRectPx'
    },
    {
      '1': 'screen_pixels_per_source_pixel',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'screenPixelsPerSourcePixel'
    },
    {
      '1': 'prefetch_margin_tiles',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'prefetchMarginTiles'
    },
    {
      '1': 'queue_missing_tiles',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'queueMissingTiles'
    },
  ],
};

/// Descriptor for `PlanViewportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planViewportRequestDescriptor = $convert.base64Decode(
    'ChNQbGFuVmlld3BvcnRSZXF1ZXN0EjEKBnNvdXJjZRgBIAEoCzIZLnNrYXZsLnRpbGVyLnYxLl'
    'NvdXJjZVJlZlIGc291cmNlEk0KF3ZpZXdwb3J0X3NvdXJjZV9yZWN0X3B4GAIgASgLMhYuc2th'
    'dmwudGlsZXIudjEuUmVjdFB4UhR2aWV3cG9ydFNvdXJjZVJlY3RQeBJCCh5zY3JlZW5fcGl4ZW'
    'xzX3Blcl9zb3VyY2VfcGl4ZWwYAyABKAFSGnNjcmVlblBpeGVsc1BlclNvdXJjZVBpeGVsEjIK'
    'FXByZWZldGNoX21hcmdpbl90aWxlcxgEIAEoDVITcHJlZmV0Y2hNYXJnaW5UaWxlcxIuChNxdW'
    'V1ZV9taXNzaW5nX3RpbGVzGAUgASgIUhFxdWV1ZU1pc3NpbmdUaWxlcw==');

@$core.Deprecated('Use planViewportResponseDescriptor instead')
const PlanViewportResponse$json = {
  '1': 'PlanViewportResponse',
  '2': [
    {
      '1': 'manifest',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.tiler.v1.ViewportTileManifest',
      '10': 'manifest'
    },
  ],
};

/// Descriptor for `PlanViewportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planViewportResponseDescriptor = $convert.base64Decode(
    'ChRQbGFuVmlld3BvcnRSZXNwb25zZRJACghtYW5pZmVzdBgBIAEoCzIkLnNrYXZsLnRpbGVyLn'
    'YxLlZpZXdwb3J0VGlsZU1hbmlmZXN0UghtYW5pZmVzdA==');
