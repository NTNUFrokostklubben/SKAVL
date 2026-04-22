// This is a generated file - do not edit.
//
// Generated from report.proto.

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

@$core.Deprecated('Use reportGenerationRequestDescriptor instead')
const ReportGenerationRequest$json = {
  '1': 'ReportGenerationRequest',
  '2': [
    {
      '1': 'project_metadata',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.anomaly.v1.ProjectMetadata',
      '10': 'projectMetadata'
    },
    {
      '1': 'anomaly_sets',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.skavl.anomaly.v1.AnomalySet',
      '10': 'anomalySets'
    },
    {
      '1': 'confidence_threshold',
      '3': 3,
      '4': 1,
      '5': 2,
      '10': 'confidenceThreshold'
    },
    {'1': 'locale', '3': 4, '4': 1, '5': 9, '10': 'locale'},
  ],
};

/// Descriptor for `ReportGenerationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportGenerationRequestDescriptor = $convert.base64Decode(
    'ChdSZXBvcnRHZW5lcmF0aW9uUmVxdWVzdBJMChBwcm9qZWN0X21ldGFkYXRhGAEgASgLMiEuc2'
    'thdmwuYW5vbWFseS52MS5Qcm9qZWN0TWV0YWRhdGFSD3Byb2plY3RNZXRhZGF0YRI/Cgxhbm9t'
    'YWx5X3NldHMYAiADKAsyHC5za2F2bC5hbm9tYWx5LnYxLkFub21hbHlTZXRSC2Fub21hbHlTZX'
    'RzEjEKFGNvbmZpZGVuY2VfdGhyZXNob2xkGAMgASgCUhNjb25maWRlbmNlVGhyZXNob2xkEhYK'
    'BmxvY2FsZRgEIAEoCVIGbG9jYWxl');

@$core.Deprecated('Use reportGenerationResponseDescriptor instead')
const ReportGenerationResponse$json = {
  '1': 'ReportGenerationResponse',
  '2': [
    {'1': 'report_url', '3': 1, '4': 1, '5': 9, '10': 'reportUrl'},
  ],
};

/// Descriptor for `ReportGenerationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportGenerationResponseDescriptor =
    $convert.base64Decode(
        'ChhSZXBvcnRHZW5lcmF0aW9uUmVzcG9uc2USHQoKcmVwb3J0X3VybBgBIAEoCVIJcmVwb3J0VX'
        'Js');
