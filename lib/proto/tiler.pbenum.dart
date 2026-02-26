// This is a generated file - do not edit.
//
// Generated from tiler.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TileState extends $pb.ProtobufEnum {
  static const TileState TILE_STATE_UNSPECIFIED =
      TileState._(0, _omitEnumNames ? '' : 'TILE_STATE_UNSPECIFIED');
  static const TileState TILE_STATE_READY =
      TileState._(1, _omitEnumNames ? '' : 'TILE_STATE_READY');
  static const TileState TILE_STATE_QUEUED =
      TileState._(2, _omitEnumNames ? '' : 'TILE_STATE_QUEUED');
  static const TileState TILE_STATE_GENERATING =
      TileState._(3, _omitEnumNames ? '' : 'TILE_STATE_GENERATING');
  static const TileState TILE_STATE_MISSING =
      TileState._(4, _omitEnumNames ? '' : 'TILE_STATE_MISSING');
  static const TileState TILE_STATE_FAILED =
      TileState._(5, _omitEnumNames ? '' : 'TILE_STATE_FAILED');

  static const $core.List<TileState> values = <TileState>[
    TILE_STATE_UNSPECIFIED,
    TILE_STATE_READY,
    TILE_STATE_QUEUED,
    TILE_STATE_GENERATING,
    TILE_STATE_MISSING,
    TILE_STATE_FAILED,
  ];

  static final $core.List<TileState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static TileState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TileState._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
