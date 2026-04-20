// This is a generated file - do not edit.
//
// Generated from report.proto.

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

import 'report.pb.dart' as $0;

export 'report.pb.dart';

/// Service for generating reports from anomaly data
@$pb.GrpcServiceName('skavl.report.v1.ReportService')
class ReportServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ReportServiceClient(super.channel, {super.options, super.interceptors});

  /// Generates a unclassified report based on the provided anomaly sets and metadata
  $grpc.ResponseFuture<$0.ReportGenerationResponse> generateReportUnclassified(
    $0.ReportGenerationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateReportUnclassified, request,
        options: options);
  }

  /// Generates a classified report based on the provided anomaly sets and metadata
  $grpc.ResponseFuture<$0.ReportGenerationResponse> generateReportClassified(
    $0.ReportGenerationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateReportClassified, request,
        options: options);
  }

  // method descriptors

  static final _$generateReportUnclassified = $grpc.ClientMethod<
          $0.ReportGenerationRequest, $0.ReportGenerationResponse>(
      '/skavl.report.v1.ReportService/GenerateReportUnclassified',
      ($0.ReportGenerationRequest value) => value.writeToBuffer(),
      $0.ReportGenerationResponse.fromBuffer);
  static final _$generateReportClassified = $grpc.ClientMethod<
          $0.ReportGenerationRequest, $0.ReportGenerationResponse>(
      '/skavl.report.v1.ReportService/GenerateReportClassified',
      ($0.ReportGenerationRequest value) => value.writeToBuffer(),
      $0.ReportGenerationResponse.fromBuffer);
}

@$pb.GrpcServiceName('skavl.report.v1.ReportService')
abstract class ReportServiceBase extends $grpc.Service {
  $core.String get $name => 'skavl.report.v1.ReportService';

  ReportServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ReportGenerationRequest,
            $0.ReportGenerationResponse>(
        'GenerateReportUnclassified',
        generateReportUnclassified_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReportGenerationRequest.fromBuffer(value),
        ($0.ReportGenerationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReportGenerationRequest,
            $0.ReportGenerationResponse>(
        'GenerateReportClassified',
        generateReportClassified_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReportGenerationRequest.fromBuffer(value),
        ($0.ReportGenerationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ReportGenerationResponse> generateReportUnclassified_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReportGenerationRequest> $request) async {
    return generateReportUnclassified($call, await $request);
  }

  $async.Future<$0.ReportGenerationResponse> generateReportUnclassified(
      $grpc.ServiceCall call, $0.ReportGenerationRequest request);

  $async.Future<$0.ReportGenerationResponse> generateReportClassified_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReportGenerationRequest> $request) async {
    return generateReportClassified($call, await $request);
  }

  $async.Future<$0.ReportGenerationResponse> generateReportClassified(
      $grpc.ServiceCall call, $0.ReportGenerationRequest request);
}
