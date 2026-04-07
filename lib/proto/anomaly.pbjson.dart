// This is a generated file - do not edit.
//
// Generated from anomaly.proto.

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

@$core.Deprecated('Use startModeDescriptor instead')
const StartMode$json = {
  '1': 'StartMode',
  '2': [
    {'1': 'START_RESTART', '2': 0},
    {'1': 'START_CONTINUE', '2': 1},
  ],
};

/// Descriptor for `StartMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List startModeDescriptor = $convert.base64Decode(
    'CglTdGFydE1vZGUSEQoNU1RBUlRfUkVTVEFSVBAAEhIKDlNUQVJUX0NPTlRJTlVFEAE=');

@$core.Deprecated('Use utmCoordinateDescriptor instead')
const UtmCoordinate$json = {
  '1': 'UtmCoordinate',
  '2': [
    {'1': 'easting', '3': 1, '4': 1, '5': 1, '10': 'easting'},
    {'1': 'northing', '3': 2, '4': 1, '5': 1, '10': 'northing'},
  ],
};

/// Descriptor for `UtmCoordinate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List utmCoordinateDescriptor = $convert.base64Decode(
    'Cg1VdG1Db29yZGluYXRlEhgKB2Vhc3RpbmcYASABKAFSB2Vhc3RpbmcSGgoIbm9ydGhpbmcYAi'
    'ABKAFSCG5vcnRoaW5n');

@$core.Deprecated('Use anomalySetDescriptor instead')
const AnomalySet$json = {
  '1': 'AnomalySet',
  '2': [
    {'1': 'image_name', '3': 1, '4': 1, '5': 9, '10': 'imageName'},
    {
      '1': 'anomaly_confidence',
      '3': 2,
      '4': 1,
      '5': 1,
      '10': 'anomalyConfidence'
    },
    {'1': 'line_number', '3': 3, '4': 1, '5': 5, '10': 'lineNumber'},
    {'1': 'image_number', '3': 4, '4': 1, '5': 5, '10': 'imageNumber'},
    {
      '1': 'geotiff_coordinate',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.skavl.anomaly.v1.UtmCoordinate',
      '10': 'geotiffCoordinate'
    },
  ],
};

/// Descriptor for `AnomalySet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anomalySetDescriptor = $convert.base64Decode(
    'CgpBbm9tYWx5U2V0Eh0KCmltYWdlX25hbWUYASABKAlSCWltYWdlTmFtZRItChJhbm9tYWx5X2'
    'NvbmZpZGVuY2UYAiABKAFSEWFub21hbHlDb25maWRlbmNlEh8KC2xpbmVfbnVtYmVyGAMgASgF'
    'UgpsaW5lTnVtYmVyEiEKDGltYWdlX251bWJlchgEIAEoBVILaW1hZ2VOdW1iZXISTgoSZ2VvdG'
    'lmZl9jb29yZGluYXRlGAUgASgLMh8uc2thdmwuYW5vbWFseS52MS5VdG1Db29yZGluYXRlUhFn'
    'ZW90aWZmQ29vcmRpbmF0ZQ==');

@$core.Deprecated('Use anomalyResponseDescriptor instead')
const AnomalyResponse$json = {
  '1': 'AnomalyResponse',
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
      '1': 'last_processed_index',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'lastProcessedIndex'
    },
    {
      '1': 'anomaly_sets',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.skavl.anomaly.v1.AnomalySet',
      '10': 'anomalySets'
    },
  ],
};

/// Descriptor for `AnomalyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anomalyResponseDescriptor = $convert.base64Decode(
    'Cg9Bbm9tYWx5UmVzcG9uc2USTAoQcHJvamVjdF9tZXRhZGF0YRgBIAEoCzIhLnNrYXZsLmFub2'
    '1hbHkudjEuUHJvamVjdE1ldGFkYXRhUg9wcm9qZWN0TWV0YWRhdGESMAoUbGFzdF9wcm9jZXNz'
    'ZWRfaW5kZXgYAiABKAVSEmxhc3RQcm9jZXNzZWRJbmRleBI/Cgxhbm9tYWx5X3NldHMYAyADKA'
    'syHC5za2F2bC5hbm9tYWx5LnYxLkFub21hbHlTZXRSC2Fub21hbHlTZXRz');

@$core.Deprecated('Use projectMetadataDescriptor instead')
const ProjectMetadata$json = {
  '1': 'ProjectMetadata',
  '2': [
    {'1': 'project_name', '3': 1, '4': 1, '5': 9, '10': 'projectName'},
    {'1': 'sosi_file_path', '3': 2, '4': 1, '5': 9, '10': 'sosiFilePath'},
    {'1': 'image_folder_path', '3': 3, '4': 1, '5': 9, '10': 'imageFolderPath'},
    {
      '1': 'sosi_water_mask_path',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'sosiWaterMaskPath',
      '17': true
    },
  ],
  '8': [
    {'1': '_sosi_water_mask_path'},
  ],
};

/// Descriptor for `ProjectMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectMetadataDescriptor = $convert.base64Decode(
    'Cg9Qcm9qZWN0TWV0YWRhdGESIQoMcHJvamVjdF9uYW1lGAEgASgJUgtwcm9qZWN0TmFtZRIkCg'
    '5zb3NpX2ZpbGVfcGF0aBgCIAEoCVIMc29zaUZpbGVQYXRoEioKEWltYWdlX2ZvbGRlcl9wYXRo'
    'GAMgASgJUg9pbWFnZUZvbGRlclBhdGgSNAoUc29zaV93YXRlcl9tYXNrX3BhdGgYBCABKAlIAF'
    'IRc29zaVdhdGVyTWFza1BhdGiIAQFCFwoVX3Nvc2lfd2F0ZXJfbWFza19wYXRo');

@$core.Deprecated('Use describeAnomalyProjectRequestDescriptor instead')
const DescribeAnomalyProjectRequest$json = {
  '1': 'DescribeAnomalyProjectRequest',
  '2': [
    {
      '1': 'project_metadata',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.anomaly.v1.ProjectMetadata',
      '10': 'projectMetadata'
    },
  ],
};

/// Descriptor for `DescribeAnomalyProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List describeAnomalyProjectRequestDescriptor =
    $convert.base64Decode(
        'Ch1EZXNjcmliZUFub21hbHlQcm9qZWN0UmVxdWVzdBJMChBwcm9qZWN0X21ldGFkYXRhGAEgAS'
        'gLMiEuc2thdmwuYW5vbWFseS52MS5Qcm9qZWN0TWV0YWRhdGFSD3Byb2plY3RNZXRhZGF0YQ==');

@$core.Deprecated('Use describeAnomalyProjectResponseDescriptor instead')
const DescribeAnomalyProjectResponse$json = {
  '1': 'DescribeAnomalyProjectResponse',
  '2': [
    {
      '1': 'project_metadata',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.anomaly.v1.ProjectMetadata',
      '10': 'projectMetadata'
    },
    {'1': 'images_in_folder', '3': 2, '4': 1, '5': 5, '10': 'imagesInFolder'},
    {
      '1': 'last_processed_image',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'lastProcessedImage'
    },
  ],
};

/// Descriptor for `DescribeAnomalyProjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List describeAnomalyProjectResponseDescriptor =
    $convert.base64Decode(
        'Ch5EZXNjcmliZUFub21hbHlQcm9qZWN0UmVzcG9uc2USTAoQcHJvamVjdF9tZXRhZGF0YRgBIA'
        'EoCzIhLnNrYXZsLmFub21hbHkudjEuUHJvamVjdE1ldGFkYXRhUg9wcm9qZWN0TWV0YWRhdGES'
        'KAoQaW1hZ2VzX2luX2ZvbGRlchgCIAEoBVIOaW1hZ2VzSW5Gb2xkZXISMAoUbGFzdF9wcm9jZX'
        'NzZWRfaW1hZ2UYAyABKAVSEmxhc3RQcm9jZXNzZWRJbWFnZQ==');

@$core.Deprecated('Use detectAnomalySetRequestDescriptor instead')
const DetectAnomalySetRequest$json = {
  '1': 'DetectAnomalySetRequest',
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
      '1': 'start_mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.skavl.anomaly.v1.StartMode',
      '10': 'startMode'
    },
  ],
};

/// Descriptor for `DetectAnomalySetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detectAnomalySetRequestDescriptor = $convert.base64Decode(
    'ChdEZXRlY3RBbm9tYWx5U2V0UmVxdWVzdBJMChBwcm9qZWN0X21ldGFkYXRhGAEgASgLMiEuc2'
    'thdmwuYW5vbWFseS52MS5Qcm9qZWN0TWV0YWRhdGFSD3Byb2plY3RNZXRhZGF0YRI6CgpzdGFy'
    'dF9tb2RlGAIgASgOMhsuc2thdmwuYW5vbWFseS52MS5TdGFydE1vZGVSCXN0YXJ0TW9kZQ==');

@$core.Deprecated('Use detectAnomalySetResponseDescriptor instead')
const DetectAnomalySetResponse$json = {
  '1': 'DetectAnomalySetResponse',
  '2': [
    {
      '1': 'anomaly_response',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.skavl.anomaly.v1.AnomalyResponse',
      '10': 'anomalyResponse'
    },
  ],
};

/// Descriptor for `DetectAnomalySetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detectAnomalySetResponseDescriptor =
    $convert.base64Decode(
        'ChhEZXRlY3RBbm9tYWx5U2V0UmVzcG9uc2USTAoQYW5vbWFseV9yZXNwb25zZRgBIAEoCzIhLn'
        'NrYXZsLmFub21hbHkudjEuQW5vbWFseVJlc3BvbnNlUg9hbm9tYWx5UmVzcG9uc2U=');
