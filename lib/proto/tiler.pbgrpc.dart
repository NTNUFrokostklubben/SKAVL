// This is a generated file - do not edit.
//
// Generated from tiler.proto.

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

import 'tiler.pb.dart' as $0;

export 'tiler.pb.dart';

@$pb.GrpcServiceName('skavl.tiler.v1.TilerService')
class TilerServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TilerServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.DescribeSourceResponse> describeSource(
    $0.DescribeSourceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$describeSource, request, options: options);
  }

  $grpc.ResponseFuture<$0.PlanViewportResponse> planViewport(
    $0.PlanViewportRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$planViewport, request, options: options);
  }

  // method descriptors

  static final _$describeSource =
      $grpc.ClientMethod<$0.DescribeSourceRequest, $0.DescribeSourceResponse>(
          '/skavl.tiler.v1.TilerService/DescribeSource',
          ($0.DescribeSourceRequest value) => value.writeToBuffer(),
          $0.DescribeSourceResponse.fromBuffer);
  static final _$planViewport =
      $grpc.ClientMethod<$0.PlanViewportRequest, $0.PlanViewportResponse>(
          '/skavl.tiler.v1.TilerService/PlanViewport',
          ($0.PlanViewportRequest value) => value.writeToBuffer(),
          $0.PlanViewportResponse.fromBuffer);
}

@$pb.GrpcServiceName('skavl.tiler.v1.TilerService')
abstract class TilerServiceBase extends $grpc.Service {
  $core.String get $name => 'skavl.tiler.v1.TilerService';

  TilerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DescribeSourceRequest,
            $0.DescribeSourceResponse>(
        'DescribeSource',
        describeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DescribeSourceRequest.fromBuffer(value),
        ($0.DescribeSourceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PlanViewportRequest, $0.PlanViewportResponse>(
            'PlanViewport',
            planViewport_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PlanViewportRequest.fromBuffer(value),
            ($0.PlanViewportResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.DescribeSourceResponse> describeSource_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DescribeSourceRequest> $request) async {
    return describeSource($call, await $request);
  }

  $async.Future<$0.DescribeSourceResponse> describeSource(
      $grpc.ServiceCall call, $0.DescribeSourceRequest request);

  $async.Future<$0.PlanViewportResponse> planViewport_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PlanViewportRequest> $request) async {
    return planViewport($call, await $request);
  }

  $async.Future<$0.PlanViewportResponse> planViewport(
      $grpc.ServiceCall call, $0.PlanViewportRequest request);
}
