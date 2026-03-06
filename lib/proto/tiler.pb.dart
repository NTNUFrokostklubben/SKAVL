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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'tiler.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'tiler.pbenum.dart';

/// Level is the zoom level to load from disk, correlates with resolution
/// x and y are global space tile coordinates
class TileCoord extends $pb.GeneratedMessage {
  factory TileCoord({
    $core.int? level,
    $core.int? x,
    $core.int? y,
  }) {
    final result = create();
    if (level != null) result.level = level;
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    return result;
  }

  TileCoord._();

  factory TileCoord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TileCoord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TileCoord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'level', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'x', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'y', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TileCoord clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TileCoord copyWith(void Function(TileCoord) updates) =>
      super.copyWith((message) => updates(message as TileCoord)) as TileCoord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TileCoord create() => TileCoord._();
  @$core.override
  TileCoord createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TileCoord getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TileCoord>(create);
  static TileCoord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get level => $_getIZ(0);
  @$pb.TagNumber(1)
  set level($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get x => $_getIZ(1);
  @$pb.TagNumber(2)
  set x($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get y => $_getIZ(2);
  @$pb.TagNumber(3)
  set y($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => $_clearField(3);
}

class TileRef extends $pb.GeneratedMessage {
  factory TileRef({
    TileCoord? coord,
    TileState? state,
    $core.String? localPath,
    $core.bool? isPrefetch,
  }) {
    final result = create();
    if (coord != null) result.coord = coord;
    if (state != null) result.state = state;
    if (localPath != null) result.localPath = localPath;
    if (isPrefetch != null) result.isPrefetch = isPrefetch;
    return result;
  }

  TileRef._();

  factory TileRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TileRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TileRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aOM<TileCoord>(1, _omitFieldNames ? '' : 'coord',
        subBuilder: TileCoord.create)
    ..aE<TileState>(2, _omitFieldNames ? '' : 'state',
        enumValues: TileState.values)
    ..aOS(3, _omitFieldNames ? '' : 'localPath')
    ..aOB(4, _omitFieldNames ? '' : 'isPrefetch')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TileRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TileRef copyWith(void Function(TileRef) updates) =>
      super.copyWith((message) => updates(message as TileRef)) as TileRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TileRef create() => TileRef._();
  @$core.override
  TileRef createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TileRef getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TileRef>(create);
  static TileRef? _defaultInstance;

  @$pb.TagNumber(1)
  TileCoord get coord => $_getN(0);
  @$pb.TagNumber(1)
  set coord(TileCoord value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCoord() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoord() => $_clearField(1);
  @$pb.TagNumber(1)
  TileCoord ensureCoord() => $_ensure(0);

  @$pb.TagNumber(2)
  TileState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(TileState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get localPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set localPath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLocalPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocalPath() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isPrefetch => $_getBF(3);
  @$pb.TagNumber(4)
  set isPrefetch($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsPrefetch() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsPrefetch() => $_clearField(4);
}

class ViewportTileManifest extends $pb.GeneratedMessage {
  factory ViewportTileManifest({
    $core.String? sourceId,
    $core.int? selectedLevel,
    $core.Iterable<TileRef>? tiles,
  }) {
    final result = create();
    if (sourceId != null) result.sourceId = sourceId;
    if (selectedLevel != null) result.selectedLevel = selectedLevel;
    if (tiles != null) result.tiles.addAll(tiles);
    return result;
  }

  ViewportTileManifest._();

  factory ViewportTileManifest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ViewportTileManifest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ViewportTileManifest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourceId')
    ..aI(2, _omitFieldNames ? '' : 'selectedLevel',
        fieldType: $pb.PbFieldType.OU3)
    ..pPM<TileRef>(3, _omitFieldNames ? '' : 'tiles',
        subBuilder: TileRef.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ViewportTileManifest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ViewportTileManifest copyWith(void Function(ViewportTileManifest) updates) =>
      super.copyWith((message) => updates(message as ViewportTileManifest))
          as ViewportTileManifest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewportTileManifest create() => ViewportTileManifest._();
  @$core.override
  ViewportTileManifest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ViewportTileManifest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ViewportTileManifest>(create);
  static ViewportTileManifest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sourceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSourceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get selectedLevel => $_getIZ(1);
  @$pb.TagNumber(2)
  set selectedLevel($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSelectedLevel() => $_has(1);
  @$pb.TagNumber(2)
  void clearSelectedLevel() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<TileRef> get tiles => $_getList(2);
}

enum SourceRef_Ref { sourceId, sourcePath, notSet }

class SourceRef extends $pb.GeneratedMessage {
  factory SourceRef({
    $core.String? sourceId,
    $core.String? sourcePath,
  }) {
    final result = create();
    if (sourceId != null) result.sourceId = sourceId;
    if (sourcePath != null) result.sourcePath = sourcePath;
    return result;
  }

  SourceRef._();

  factory SourceRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SourceRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SourceRef_Ref> _SourceRef_RefByTag = {
    1: SourceRef_Ref.sourceId,
    2: SourceRef_Ref.sourcePath,
    0: SourceRef_Ref.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'sourceId')
    ..aOS(2, _omitFieldNames ? '' : 'sourcePath')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SourceRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SourceRef copyWith(void Function(SourceRef) updates) =>
      super.copyWith((message) => updates(message as SourceRef)) as SourceRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceRef create() => SourceRef._();
  @$core.override
  SourceRef createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SourceRef getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SourceRef>(create);
  static SourceRef? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  SourceRef_Ref whichRef() => _SourceRef_RefByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearRef() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get sourceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSourceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sourcePath => $_getSZ(1);
  @$pb.TagNumber(2)
  set sourcePath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourcePath() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourcePath() => $_clearField(2);
}

/// x and y are global coordinates in source pixels (level 0)
class RectPx extends $pb.GeneratedMessage {
  factory RectPx({
    $fixnum.Int64? x,
    $fixnum.Int64? y,
    $core.int? width,
    $core.int? height,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    return result;
  }

  RectPx._();

  factory RectPx.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RectPx.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RectPx',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'x')
    ..aInt64(2, _omitFieldNames ? '' : 'y')
    ..aI(3, _omitFieldNames ? '' : 'width', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'height', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RectPx clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RectPx copyWith(void Function(RectPx) updates) =>
      super.copyWith((message) => updates(message as RectPx)) as RectPx;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RectPx create() => RectPx._();
  @$core.override
  RectPx createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RectPx getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RectPx>(create);
  static RectPx? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get x => $_getI64(0);
  @$pb.TagNumber(1)
  set x($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get y => $_getI64(1);
  @$pb.TagNumber(2)
  set y($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get width => $_getIZ(2);
  @$pb.TagNumber(3)
  set width($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get height => $_getIZ(3);
  @$pb.TagNumber(4)
  set height($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => $_clearField(4);
}

class TilesetDescriptor extends $pb.GeneratedMessage {
  factory TilesetDescriptor({
    $core.String? sourceId,
    $core.int? sourceWidthPx,
    $core.int? sourceHeightPx,
    $core.int? tileWidthPx,
    $core.int? tileHeightPx,
    $core.int? minLevel,
    $core.int? maxLevel,
  }) {
    final result = create();
    if (sourceId != null) result.sourceId = sourceId;
    if (sourceWidthPx != null) result.sourceWidthPx = sourceWidthPx;
    if (sourceHeightPx != null) result.sourceHeightPx = sourceHeightPx;
    if (tileWidthPx != null) result.tileWidthPx = tileWidthPx;
    if (tileHeightPx != null) result.tileHeightPx = tileHeightPx;
    if (minLevel != null) result.minLevel = minLevel;
    if (maxLevel != null) result.maxLevel = maxLevel;
    return result;
  }

  TilesetDescriptor._();

  factory TilesetDescriptor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TilesetDescriptor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TilesetDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourceId')
    ..aI(2, _omitFieldNames ? '' : 'sourceWidthPx',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'sourceHeightPx',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'tileWidthPx',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'tileHeightPx',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'minLevel', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'maxLevel', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TilesetDescriptor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TilesetDescriptor copyWith(void Function(TilesetDescriptor) updates) =>
      super.copyWith((message) => updates(message as TilesetDescriptor))
          as TilesetDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TilesetDescriptor create() => TilesetDescriptor._();
  @$core.override
  TilesetDescriptor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TilesetDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TilesetDescriptor>(create);
  static TilesetDescriptor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sourceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSourceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get sourceWidthPx => $_getIZ(1);
  @$pb.TagNumber(2)
  set sourceWidthPx($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSourceWidthPx() => $_has(1);
  @$pb.TagNumber(2)
  void clearSourceWidthPx() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get sourceHeightPx => $_getIZ(2);
  @$pb.TagNumber(3)
  set sourceHeightPx($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceHeightPx() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceHeightPx() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get tileWidthPx => $_getIZ(3);
  @$pb.TagNumber(4)
  set tileWidthPx($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTileWidthPx() => $_has(3);
  @$pb.TagNumber(4)
  void clearTileWidthPx() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get tileHeightPx => $_getIZ(4);
  @$pb.TagNumber(5)
  set tileHeightPx($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTileHeightPx() => $_has(4);
  @$pb.TagNumber(5)
  void clearTileHeightPx() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get minLevel => $_getIZ(5);
  @$pb.TagNumber(6)
  set minLevel($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMinLevel() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinLevel() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get maxLevel => $_getIZ(6);
  @$pb.TagNumber(7)
  set maxLevel($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMaxLevel() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxLevel() => $_clearField(7);
}

class DescribeSourceRequest extends $pb.GeneratedMessage {
  factory DescribeSourceRequest({
    SourceRef? source,
  }) {
    final result = create();
    if (source != null) result.source = source;
    return result;
  }

  DescribeSourceRequest._();

  factory DescribeSourceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DescribeSourceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DescribeSourceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aOM<SourceRef>(1, _omitFieldNames ? '' : 'source',
        subBuilder: SourceRef.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeSourceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeSourceRequest copyWith(
          void Function(DescribeSourceRequest) updates) =>
      super.copyWith((message) => updates(message as DescribeSourceRequest))
          as DescribeSourceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DescribeSourceRequest create() => DescribeSourceRequest._();
  @$core.override
  DescribeSourceRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DescribeSourceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DescribeSourceRequest>(create);
  static DescribeSourceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SourceRef get source => $_getN(0);
  @$pb.TagNumber(1)
  set source(SourceRef value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => $_clearField(1);
  @$pb.TagNumber(1)
  SourceRef ensureSource() => $_ensure(0);
}

class DescribeSourceResponse extends $pb.GeneratedMessage {
  factory DescribeSourceResponse({
    TilesetDescriptor? descriptor,
  }) {
    final result = create();
    if (descriptor != null) result.descriptor = descriptor;
    return result;
  }

  DescribeSourceResponse._();

  factory DescribeSourceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DescribeSourceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DescribeSourceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aOM<TilesetDescriptor>(1, _omitFieldNames ? '' : 'descriptor',
        subBuilder: TilesetDescriptor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeSourceResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeSourceResponse copyWith(
          void Function(DescribeSourceResponse) updates) =>
      super.copyWith((message) => updates(message as DescribeSourceResponse))
          as DescribeSourceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DescribeSourceResponse create() => DescribeSourceResponse._();
  @$core.override
  DescribeSourceResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DescribeSourceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DescribeSourceResponse>(create);
  static DescribeSourceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TilesetDescriptor get descriptor => $_getN(0);
  @$pb.TagNumber(1)
  set descriptor(TilesetDescriptor value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDescriptor() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescriptor() => $_clearField(1);
  @$pb.TagNumber(1)
  TilesetDescriptor ensureDescriptor() => $_ensure(0);
}

class PlanViewportRequest extends $pb.GeneratedMessage {
  factory PlanViewportRequest({
    SourceRef? source,
    RectPx? viewportSourceRectPx,
    $core.double? screenPixelsPerSourcePixel,
    $core.int? prefetchMarginTiles,
    $core.bool? queueMissingTiles,
  }) {
    final result = create();
    if (source != null) result.source = source;
    if (viewportSourceRectPx != null)
      result.viewportSourceRectPx = viewportSourceRectPx;
    if (screenPixelsPerSourcePixel != null)
      result.screenPixelsPerSourcePixel = screenPixelsPerSourcePixel;
    if (prefetchMarginTiles != null)
      result.prefetchMarginTiles = prefetchMarginTiles;
    if (queueMissingTiles != null) result.queueMissingTiles = queueMissingTiles;
    return result;
  }

  PlanViewportRequest._();

  factory PlanViewportRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlanViewportRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlanViewportRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aOM<SourceRef>(1, _omitFieldNames ? '' : 'source',
        subBuilder: SourceRef.create)
    ..aOM<RectPx>(2, _omitFieldNames ? '' : 'viewportSourceRectPx',
        subBuilder: RectPx.create)
    ..aD(3, _omitFieldNames ? '' : 'screenPixelsPerSourcePixel')
    ..aI(4, _omitFieldNames ? '' : 'prefetchMarginTiles',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(5, _omitFieldNames ? '' : 'queueMissingTiles')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanViewportRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanViewportRequest copyWith(void Function(PlanViewportRequest) updates) =>
      super.copyWith((message) => updates(message as PlanViewportRequest))
          as PlanViewportRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlanViewportRequest create() => PlanViewportRequest._();
  @$core.override
  PlanViewportRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlanViewportRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlanViewportRequest>(create);
  static PlanViewportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SourceRef get source => $_getN(0);
  @$pb.TagNumber(1)
  set source(SourceRef value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => $_clearField(1);
  @$pb.TagNumber(1)
  SourceRef ensureSource() => $_ensure(0);

  @$pb.TagNumber(2)
  RectPx get viewportSourceRectPx => $_getN(1);
  @$pb.TagNumber(2)
  set viewportSourceRectPx(RectPx value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasViewportSourceRectPx() => $_has(1);
  @$pb.TagNumber(2)
  void clearViewportSourceRectPx() => $_clearField(2);
  @$pb.TagNumber(2)
  RectPx ensureViewportSourceRectPx() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get screenPixelsPerSourcePixel => $_getN(2);
  @$pb.TagNumber(3)
  set screenPixelsPerSourcePixel($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasScreenPixelsPerSourcePixel() => $_has(2);
  @$pb.TagNumber(3)
  void clearScreenPixelsPerSourcePixel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get prefetchMarginTiles => $_getIZ(3);
  @$pb.TagNumber(4)
  set prefetchMarginTiles($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPrefetchMarginTiles() => $_has(3);
  @$pb.TagNumber(4)
  void clearPrefetchMarginTiles() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get queueMissingTiles => $_getBF(4);
  @$pb.TagNumber(5)
  set queueMissingTiles($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQueueMissingTiles() => $_has(4);
  @$pb.TagNumber(5)
  void clearQueueMissingTiles() => $_clearField(5);
}

class PlanViewportResponse extends $pb.GeneratedMessage {
  factory PlanViewportResponse({
    ViewportTileManifest? manifest,
  }) {
    final result = create();
    if (manifest != null) result.manifest = manifest;
    return result;
  }

  PlanViewportResponse._();

  factory PlanViewportResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlanViewportResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlanViewportResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl.tiler.v1'),
      createEmptyInstance: create)
    ..aOM<ViewportTileManifest>(1, _omitFieldNames ? '' : 'manifest',
        subBuilder: ViewportTileManifest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanViewportResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlanViewportResponse copyWith(void Function(PlanViewportResponse) updates) =>
      super.copyWith((message) => updates(message as PlanViewportResponse))
          as PlanViewportResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlanViewportResponse create() => PlanViewportResponse._();
  @$core.override
  PlanViewportResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlanViewportResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlanViewportResponse>(create);
  static PlanViewportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ViewportTileManifest get manifest => $_getN(0);
  @$pb.TagNumber(1)
  set manifest(ViewportTileManifest value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasManifest() => $_has(0);
  @$pb.TagNumber(1)
  void clearManifest() => $_clearField(1);
  @$pb.TagNumber(1)
  ViewportTileManifest ensureManifest() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
