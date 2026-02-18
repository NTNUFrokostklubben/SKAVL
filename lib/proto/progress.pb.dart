// This is a generated file - do not edit.
//
// Generated from progress.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// *
///  Testing proto package for per-repo building as well as for submodules
class ProgressReport extends $pb.GeneratedMessage {
  factory ProgressReport({
    $core.String? projectName,
    $core.double? progress,
  }) {
    final result = create();
    if (projectName != null) result.projectName = projectName;
    if (progress != null) result.progress = progress;
    return result;
  }

  ProgressReport._();

  factory ProgressReport.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProgressReport.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProgressReport',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'skavl'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'projectName')
    ..aD(2, _omitFieldNames ? '' : 'progress', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProgressReport clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProgressReport copyWith(void Function(ProgressReport) updates) =>
      super.copyWith((message) => updates(message as ProgressReport))
          as ProgressReport;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProgressReport create() => ProgressReport._();
  @$core.override
  ProgressReport createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProgressReport getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProgressReport>(create);
  static ProgressReport? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get projectName => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectName() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get progress => $_getN(1);
  @$pb.TagNumber(2)
  set progress($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
