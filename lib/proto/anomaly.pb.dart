// This is a generated file - do not edit.
//
// Generated from anomaly.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'anomaly.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'anomaly.pbenum.dart';

/// Easting and Northing meter offsets from the 0,0 origo for the UTM zone (usually center-point from geotiff gdalinfo)
class UtmCoordinate extends $pb.GeneratedMessage {
  factory UtmCoordinate({
    $core.double? easting,
    $core.double? northing,
  }) {
    final result = create();
    if (easting != null) result.easting = easting;
    if (northing != null) result.northing = northing;
    return result;
  }

  UtmCoordinate._();

  factory UtmCoordinate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UtmCoordinate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UtmCoordinate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'easting')
    ..aD(2, _omitFieldNames ? '' : 'northing')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UtmCoordinate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UtmCoordinate copyWith(void Function(UtmCoordinate) updates) =>
      super.copyWith((message) => updates(message as UtmCoordinate))
          as UtmCoordinate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UtmCoordinate create() => UtmCoordinate._();
  @$core.override
  UtmCoordinate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UtmCoordinate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UtmCoordinate>(create);
  static UtmCoordinate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get easting => $_getN(0);
  @$pb.TagNumber(1)
  set easting($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEasting() => $_has(0);
  @$pb.TagNumber(1)
  void clearEasting() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get northing => $_getN(1);
  @$pb.TagNumber(2)
  set northing($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNorthing() => $_has(1);
  @$pb.TagNumber(2)
  void clearNorthing() => $_clearField(2);
}

/// Data per image analyzed.
class AnomalySet extends $pb.GeneratedMessage {
  factory AnomalySet({
    $core.String? imageName,
    $core.double? anomalyConfidence,
    $core.int? lineNumber,
    $core.int? imageNumber,
    UtmCoordinate? geotiffCoordinate,
  }) {
    final result = create();
    if (imageName != null) result.imageName = imageName;
    if (anomalyConfidence != null) result.anomalyConfidence = anomalyConfidence;
    if (lineNumber != null) result.lineNumber = lineNumber;
    if (imageNumber != null) result.imageNumber = imageNumber;
    if (geotiffCoordinate != null) result.geotiffCoordinate = geotiffCoordinate;
    return result;
  }

  AnomalySet._();

  factory AnomalySet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnomalySet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnomalySet',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'imageName')
    ..aD(2, _omitFieldNames ? '' : 'anomalyConfidence')
    ..aI(3, _omitFieldNames ? '' : 'lineNumber')
    ..aI(4, _omitFieldNames ? '' : 'imageNumber')
    ..aOM<UtmCoordinate>(5, _omitFieldNames ? '' : 'geotiffCoordinate',
        subBuilder: UtmCoordinate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnomalySet clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnomalySet copyWith(void Function(AnomalySet) updates) =>
      super.copyWith((message) => updates(message as AnomalySet)) as AnomalySet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnomalySet create() => AnomalySet._();
  @$core.override
  AnomalySet createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnomalySet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnomalySet>(create);
  static AnomalySet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imageName => $_getSZ(0);
  @$pb.TagNumber(1)
  set imageName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImageName() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get anomalyConfidence => $_getN(1);
  @$pb.TagNumber(2)
  set anomalyConfidence($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAnomalyConfidence() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnomalyConfidence() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get lineNumber => $_getIZ(2);
  @$pb.TagNumber(3)
  set lineNumber($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLineNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearLineNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get imageNumber => $_getIZ(3);
  @$pb.TagNumber(4)
  set imageNumber($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  UtmCoordinate get geotiffCoordinate => $_getN(4);
  @$pb.TagNumber(5)
  set geotiffCoordinate(UtmCoordinate value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasGeotiffCoordinate() => $_has(4);
  @$pb.TagNumber(5)
  void clearGeotiffCoordinate() => $_clearField(5);
  @$pb.TagNumber(5)
  UtmCoordinate ensureGeotiffCoordinate() => $_ensure(4);
}

/// List of images processed with their confidence levels
class AnomalyResponse extends $pb.GeneratedMessage {
  factory AnomalyResponse({
    ProjectMetadata? projectMetadata,
    $core.int? lastProcessedIndex,
    $core.Iterable<AnomalySet>? anomalySets,
  }) {
    final result = create();
    if (projectMetadata != null) result.projectMetadata = projectMetadata;
    if (lastProcessedIndex != null)
      result.lastProcessedIndex = lastProcessedIndex;
    if (anomalySets != null) result.anomalySets.addAll(anomalySets);
    return result;
  }

  AnomalyResponse._();

  factory AnomalyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnomalyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnomalyResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aOM<ProjectMetadata>(1, _omitFieldNames ? '' : 'projectMetadata',
        subBuilder: ProjectMetadata.create)
    ..aI(2, _omitFieldNames ? '' : 'lastProcessedIndex')
    ..pPM<AnomalySet>(3, _omitFieldNames ? '' : 'anomalySets',
        subBuilder: AnomalySet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnomalyResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnomalyResponse copyWith(void Function(AnomalyResponse) updates) =>
      super.copyWith((message) => updates(message as AnomalyResponse))
          as AnomalyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnomalyResponse create() => AnomalyResponse._();
  @$core.override
  AnomalyResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnomalyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnomalyResponse>(create);
  static AnomalyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ProjectMetadata get projectMetadata => $_getN(0);
  @$pb.TagNumber(1)
  set projectMetadata(ProjectMetadata value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectMetadata() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectMetadata() => $_clearField(1);
  @$pb.TagNumber(1)
  ProjectMetadata ensureProjectMetadata() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get lastProcessedIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set lastProcessedIndex($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastProcessedIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastProcessedIndex() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<AnomalySet> get anomalySets => $_getList(2);
}

/// Describes the project
class ProjectMetadata extends $pb.GeneratedMessage {
  factory ProjectMetadata({
    $core.String? projectName,
    $core.String? sosiFilePath,
    $core.String? imageFolderPath,
    $core.String? sosiWaterMaskPath,
  }) {
    final result = create();
    if (projectName != null) result.projectName = projectName;
    if (sosiFilePath != null) result.sosiFilePath = sosiFilePath;
    if (imageFolderPath != null) result.imageFolderPath = imageFolderPath;
    if (sosiWaterMaskPath != null) result.sosiWaterMaskPath = sosiWaterMaskPath;
    return result;
  }

  ProjectMetadata._();

  factory ProjectMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProjectMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProjectMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectName')
    ..aOS(2, _omitFieldNames ? '' : 'sosiFilePath')
    ..aOS(3, _omitFieldNames ? '' : 'imageFolderPath')
    ..aOS(4, _omitFieldNames ? '' : 'sosiWaterMaskPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProjectMetadata clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProjectMetadata copyWith(void Function(ProjectMetadata) updates) =>
      super.copyWith((message) => updates(message as ProjectMetadata))
          as ProjectMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProjectMetadata create() => ProjectMetadata._();
  @$core.override
  ProjectMetadata createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProjectMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProjectMetadata>(create);
  static ProjectMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sosiFilePath => $_getSZ(1);
  @$pb.TagNumber(2)
  set sosiFilePath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSosiFilePath() => $_has(1);
  @$pb.TagNumber(2)
  void clearSosiFilePath() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get imageFolderPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set imageFolderPath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasImageFolderPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearImageFolderPath() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sosiWaterMaskPath => $_getSZ(3);
  @$pb.TagNumber(4)
  set sosiWaterMaskPath($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSosiWaterMaskPath() => $_has(3);
  @$pb.TagNumber(4)
  void clearSosiWaterMaskPath() => $_clearField(4);
}

/// Request to anomaly server to see if project exists and
/// if folder locations are accessible for the anomaly server.
class DescribeAnomalyProjectRequest extends $pb.GeneratedMessage {
  factory DescribeAnomalyProjectRequest({
    ProjectMetadata? projectMetadata,
  }) {
    final result = create();
    if (projectMetadata != null) result.projectMetadata = projectMetadata;
    return result;
  }

  DescribeAnomalyProjectRequest._();

  factory DescribeAnomalyProjectRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DescribeAnomalyProjectRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DescribeAnomalyProjectRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aOM<ProjectMetadata>(1, _omitFieldNames ? '' : 'projectMetadata',
        subBuilder: ProjectMetadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeAnomalyProjectRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeAnomalyProjectRequest copyWith(
          void Function(DescribeAnomalyProjectRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DescribeAnomalyProjectRequest))
          as DescribeAnomalyProjectRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DescribeAnomalyProjectRequest create() =>
      DescribeAnomalyProjectRequest._();
  @$core.override
  DescribeAnomalyProjectRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DescribeAnomalyProjectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DescribeAnomalyProjectRequest>(create);
  static DescribeAnomalyProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ProjectMetadata get projectMetadata => $_getN(0);
  @$pb.TagNumber(1)
  set projectMetadata(ProjectMetadata value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectMetadata() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectMetadata() => $_clearField(1);
  @$pb.TagNumber(1)
  ProjectMetadata ensureProjectMetadata() => $_ensure(0);
}

/// Basic response if there are images in folder and if project exists or not
class DescribeAnomalyProjectResponse extends $pb.GeneratedMessage {
  factory DescribeAnomalyProjectResponse({
    ProjectMetadata? projectMetadata,
    $core.int? imagesInFolder,
    $core.int? lastProcessedImage,
  }) {
    final result = create();
    if (projectMetadata != null) result.projectMetadata = projectMetadata;
    if (imagesInFolder != null) result.imagesInFolder = imagesInFolder;
    if (lastProcessedImage != null)
      result.lastProcessedImage = lastProcessedImage;
    return result;
  }

  DescribeAnomalyProjectResponse._();

  factory DescribeAnomalyProjectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DescribeAnomalyProjectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DescribeAnomalyProjectResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aOM<ProjectMetadata>(1, _omitFieldNames ? '' : 'projectMetadata',
        subBuilder: ProjectMetadata.create)
    ..aI(2, _omitFieldNames ? '' : 'imagesInFolder')
    ..aI(3, _omitFieldNames ? '' : 'lastProcessedImage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeAnomalyProjectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DescribeAnomalyProjectResponse copyWith(
          void Function(DescribeAnomalyProjectResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DescribeAnomalyProjectResponse))
          as DescribeAnomalyProjectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DescribeAnomalyProjectResponse create() =>
      DescribeAnomalyProjectResponse._();
  @$core.override
  DescribeAnomalyProjectResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DescribeAnomalyProjectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DescribeAnomalyProjectResponse>(create);
  static DescribeAnomalyProjectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ProjectMetadata get projectMetadata => $_getN(0);
  @$pb.TagNumber(1)
  set projectMetadata(ProjectMetadata value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectMetadata() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectMetadata() => $_clearField(1);
  @$pb.TagNumber(1)
  ProjectMetadata ensureProjectMetadata() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get imagesInFolder => $_getIZ(1);
  @$pb.TagNumber(2)
  set imagesInFolder($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImagesInFolder() => $_has(1);
  @$pb.TagNumber(2)
  void clearImagesInFolder() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get lastProcessedImage => $_getIZ(2);
  @$pb.TagNumber(3)
  set lastProcessedImage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastProcessedImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastProcessedImage() => $_clearField(3);
}

/// Request to start an anomaly analysis based on a project
/// Start mode describes if the analysis should start from image one or continue
/// from where the previous analysis failed or stopped
class DetectAnomalySetRequest extends $pb.GeneratedMessage {
  factory DetectAnomalySetRequest({
    ProjectMetadata? projectMetadata,
    StartMode? startMode,
  }) {
    final result = create();
    if (projectMetadata != null) result.projectMetadata = projectMetadata;
    if (startMode != null) result.startMode = startMode;
    return result;
  }

  DetectAnomalySetRequest._();

  factory DetectAnomalySetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DetectAnomalySetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DetectAnomalySetRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aOM<ProjectMetadata>(1, _omitFieldNames ? '' : 'projectMetadata',
        subBuilder: ProjectMetadata.create)
    ..aE<StartMode>(2, _omitFieldNames ? '' : 'startMode',
        enumValues: StartMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetectAnomalySetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetectAnomalySetRequest copyWith(
          void Function(DetectAnomalySetRequest) updates) =>
      super.copyWith((message) => updates(message as DetectAnomalySetRequest))
          as DetectAnomalySetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DetectAnomalySetRequest create() => DetectAnomalySetRequest._();
  @$core.override
  DetectAnomalySetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DetectAnomalySetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DetectAnomalySetRequest>(create);
  static DetectAnomalySetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ProjectMetadata get projectMetadata => $_getN(0);
  @$pb.TagNumber(1)
  set projectMetadata(ProjectMetadata value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectMetadata() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectMetadata() => $_clearField(1);
  @$pb.TagNumber(1)
  ProjectMetadata ensureProjectMetadata() => $_ensure(0);

  @$pb.TagNumber(2)
  StartMode get startMode => $_getN(1);
  @$pb.TagNumber(2)
  set startMode(StartMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStartMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartMode() => $_clearField(2);
}

/// Returned once an anomaly analysis is complete or closed
class DetectAnomalySetResponse extends $pb.GeneratedMessage {
  factory DetectAnomalySetResponse({
    AnomalyResponse? anomalyResponse,
  }) {
    final result = create();
    if (anomalyResponse != null) result.anomalyResponse = anomalyResponse;
    return result;
  }

  DetectAnomalySetResponse._();

  factory DetectAnomalySetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DetectAnomalySetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DetectAnomalySetResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.anomaly.v1'),
      createEmptyInstance: create)
    ..aOM<AnomalyResponse>(1, _omitFieldNames ? '' : 'anomalyResponse',
        subBuilder: AnomalyResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetectAnomalySetResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetectAnomalySetResponse copyWith(
          void Function(DetectAnomalySetResponse) updates) =>
      super.copyWith((message) => updates(message as DetectAnomalySetResponse))
          as DetectAnomalySetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DetectAnomalySetResponse create() => DetectAnomalySetResponse._();
  @$core.override
  DetectAnomalySetResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DetectAnomalySetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DetectAnomalySetResponse>(create);
  static DetectAnomalySetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AnomalyResponse get anomalyResponse => $_getN(0);
  @$pb.TagNumber(1)
  set anomalyResponse(AnomalyResponse value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAnomalyResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnomalyResponse() => $_clearField(1);
  @$pb.TagNumber(1)
  AnomalyResponse ensureAnomalyResponse() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
