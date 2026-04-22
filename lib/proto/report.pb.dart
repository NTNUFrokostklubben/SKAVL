// This is a generated file - do not edit.
//
// Generated from report.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'anomaly.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message for generating a report based on anomaly data
class ReportGenerationRequest extends $pb.GeneratedMessage {
  factory ReportGenerationRequest({
    $1.ProjectMetadata? projectMetadata,
    $core.Iterable<$1.AnomalySet>? anomalySets,
    $core.double? confidenceThreshold,
    $core.String? locale,
  }) {
    final result = create();
    if (projectMetadata != null) result.projectMetadata = projectMetadata;
    if (anomalySets != null) result.anomalySets.addAll(anomalySets);
    if (confidenceThreshold != null)
      result.confidenceThreshold = confidenceThreshold;
    if (locale != null) result.locale = locale;
    return result;
  }

  ReportGenerationRequest._();

  factory ReportGenerationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReportGenerationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReportGenerationRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.report.v1'),
      createEmptyInstance: create)
    ..aOM<$1.ProjectMetadata>(1, _omitFieldNames ? '' : 'projectMetadata',
        subBuilder: $1.ProjectMetadata.create)
    ..pPM<$1.AnomalySet>(2, _omitFieldNames ? '' : 'anomalySets',
        subBuilder: $1.AnomalySet.create)
    ..aD(3, _omitFieldNames ? '' : 'confidenceThreshold',
        fieldType: $pb.PbFieldType.OF)
    ..aOS(4, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportGenerationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportGenerationRequest copyWith(
          void Function(ReportGenerationRequest) updates) =>
      super.copyWith((message) => updates(message as ReportGenerationRequest))
          as ReportGenerationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReportGenerationRequest create() => ReportGenerationRequest._();
  @$core.override
  ReportGenerationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReportGenerationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReportGenerationRequest>(create);
  static ReportGenerationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.ProjectMetadata get projectMetadata => $_getN(0);
  @$pb.TagNumber(1)
  set projectMetadata($1.ProjectMetadata value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectMetadata() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectMetadata() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.ProjectMetadata ensureProjectMetadata() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$1.AnomalySet> get anomalySets => $_getList(1);

  @$pb.TagNumber(3)
  $core.double get confidenceThreshold => $_getN(2);
  @$pb.TagNumber(3)
  set confidenceThreshold($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConfidenceThreshold() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfidenceThreshold() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get locale => $_getSZ(3);
  @$pb.TagNumber(4)
  set locale($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLocale() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocale() => $_clearField(4);
}

/// Response containing the URL to the generated report
class ReportGenerationResponse extends $pb.GeneratedMessage {
  factory ReportGenerationResponse({
    $core.String? reportUrl,
  }) {
    final result = create();
    if (reportUrl != null) result.reportUrl = reportUrl;
    return result;
  }

  ReportGenerationResponse._();

  factory ReportGenerationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReportGenerationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReportGenerationResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'skavl.report.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reportUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportGenerationResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportGenerationResponse copyWith(
          void Function(ReportGenerationResponse) updates) =>
      super.copyWith((message) => updates(message as ReportGenerationResponse))
          as ReportGenerationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReportGenerationResponse create() => ReportGenerationResponse._();
  @$core.override
  ReportGenerationResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReportGenerationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReportGenerationResponse>(create);
  static ReportGenerationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reportUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set reportUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReportUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearReportUrl() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
