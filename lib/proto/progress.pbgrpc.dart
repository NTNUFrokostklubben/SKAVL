// This is a generated file - do not edit.
//
// Generated from progress.proto.

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

import 'progress.pb.dart' as $0;

export 'progress.pb.dart';

@$pb.GrpcServiceName('skavl.ProgressService')
class ProgressServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ProgressServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ProgressReport> getProgress(
    $0.ProgressRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProgress, request, options: options);
  }

  // method descriptors

  static final _$getProgress =
      $grpc.ClientMethod<$0.ProgressRequest, $0.ProgressReport>(
          '/skavl.ProgressService/GetProgress',
          ($0.ProgressRequest value) => value.writeToBuffer(),
          $0.ProgressReport.fromBuffer);
}

@$pb.GrpcServiceName('skavl.ProgressService')
abstract class ProgressServiceBase extends $grpc.Service {
  $core.String get $name => 'skavl.ProgressService';

  ProgressServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ProgressRequest, $0.ProgressReport>(
        'GetProgress',
        getProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProgressRequest.fromBuffer(value),
        ($0.ProgressReport value) => value.writeToBuffer()));
  }

  $async.Future<$0.ProgressReport> getProgress_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ProgressRequest> $request) async {
    return getProgress($call, await $request);
  }

  $async.Future<$0.ProgressReport> getProgress(
      $grpc.ServiceCall call, $0.ProgressRequest request);
}
