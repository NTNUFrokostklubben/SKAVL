// This is a generated file - do not edit.
//
// Generated from anomaly.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'anomaly.pb.dart' as $0;

export 'anomaly.pb.dart';

/// gRPC contracts
@$pb.GrpcServiceName('skavl.anomaly.v1.AnomalyDetectorService')
class AnomalyDetectorServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AnomalyDetectorServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.DescribeAnomalyProjectResponse>
      describeAnomalyProject(
    $0.DescribeAnomalyProjectRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$describeAnomalyProject, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DetectAnomalySetResponse> detectAnomalySet(
    $0.DetectAnomalySetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$detectAnomalySet, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetProgressResponse> getProgress(
    $0.GetProgressRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProgress, request, options: options);
  }

  // method descriptors

  static final _$describeAnomalyProject = $grpc.ClientMethod<
          $0.DescribeAnomalyProjectRequest, $0.DescribeAnomalyProjectResponse>(
      '/skavl.anomaly.v1.AnomalyDetectorService/DescribeAnomalyProject',
      ($0.DescribeAnomalyProjectRequest value) => value.writeToBuffer(),
      $0.DescribeAnomalyProjectResponse.fromBuffer);
  static final _$detectAnomalySet = $grpc.ClientMethod<
          $0.DetectAnomalySetRequest, $0.DetectAnomalySetResponse>(
      '/skavl.anomaly.v1.AnomalyDetectorService/DetectAnomalySet',
      ($0.DetectAnomalySetRequest value) => value.writeToBuffer(),
      $0.DetectAnomalySetResponse.fromBuffer);
  static final _$getProgress =
      $grpc.ClientMethod<$0.GetProgressRequest, $0.GetProgressResponse>(
          '/skavl.anomaly.v1.AnomalyDetectorService/GetProgress',
          ($0.GetProgressRequest value) => value.writeToBuffer(),
          $0.GetProgressResponse.fromBuffer);
}

@$pb.GrpcServiceName('skavl.anomaly.v1.AnomalyDetectorService')
abstract class AnomalyDetectorServiceBase extends $grpc.Service {
  $core.String get $name => 'skavl.anomaly.v1.AnomalyDetectorService';

  AnomalyDetectorServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DescribeAnomalyProjectRequest,
            $0.DescribeAnomalyProjectResponse>(
        'DescribeAnomalyProject',
        describeAnomalyProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DescribeAnomalyProjectRequest.fromBuffer(value),
        ($0.DescribeAnomalyProjectResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DetectAnomalySetRequest,
            $0.DetectAnomalySetResponse>(
        'DetectAnomalySet',
        detectAnomalySet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DetectAnomalySetRequest.fromBuffer(value),
        ($0.DetectAnomalySetResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetProgressRequest, $0.GetProgressResponse>(
            'GetProgress',
            getProgress_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetProgressRequest.fromBuffer(value),
            ($0.GetProgressResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.DescribeAnomalyProjectResponse> describeAnomalyProject_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DescribeAnomalyProjectRequest> $request) async {
    return describeAnomalyProject($call, await $request);
  }

  $async.Future<$0.DescribeAnomalyProjectResponse> describeAnomalyProject(
      $grpc.ServiceCall call, $0.DescribeAnomalyProjectRequest request);

  $async.Future<$0.DetectAnomalySetResponse> detectAnomalySet_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DetectAnomalySetRequest> $request) async {
    return detectAnomalySet($call, await $request);
  }

  $async.Future<$0.DetectAnomalySetResponse> detectAnomalySet(
      $grpc.ServiceCall call, $0.DetectAnomalySetRequest request);

  $async.Future<$0.GetProgressResponse> getProgress_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetProgressRequest> $request) async {
    return getProgress($call, await $request);
  }

  $async.Future<$0.GetProgressResponse> getProgress(
      $grpc.ServiceCall call, $0.GetProgressRequest request);
}
