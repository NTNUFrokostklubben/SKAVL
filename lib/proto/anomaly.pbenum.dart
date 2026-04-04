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

/// Enum to declare if Anomaly server should continue processing where it left off or if it should restart
class StartMode extends $pb.ProtobufEnum {
  static const StartMode START_RESTART =
      StartMode._(0, _omitEnumNames ? '' : 'START_RESTART');
  static const StartMode START_CONTINUE =
      StartMode._(1, _omitEnumNames ? '' : 'START_CONTINUE');

  static const $core.List<StartMode> values = <StartMode>[
    START_RESTART,
    START_CONTINUE,
  ];

  static final $core.List<StartMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static StartMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StartMode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
