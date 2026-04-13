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

  /// Generates a report based on the provided anomaly sets and metadata
  $grpc.ResponseFuture<$0.ReportGenerationResponse> generateReport(
    $0.ReportGenerationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateReport, request, options: options);
  }

  // method descriptors

  static final _$generateReport = $grpc.ClientMethod<$0.ReportGenerationRequest,
          $0.ReportGenerationResponse>(
      '/skavl.report.v1.ReportService/GenerateReport',
      ($0.ReportGenerationRequest value) => value.writeToBuffer(),
      $0.ReportGenerationResponse.fromBuffer);
}

@$pb.GrpcServiceName('skavl.report.v1.ReportService')
abstract class ReportServiceBase extends $grpc.Service {
  $core.String get $name => 'skavl.report.v1.ReportService';

  ReportServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ReportGenerationRequest,
            $0.ReportGenerationResponse>(
        'GenerateReport',
        generateReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReportGenerationRequest.fromBuffer(value),
        ($0.ReportGenerationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ReportGenerationResponse> generateReport_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReportGenerationRequest> $request) async {
    return generateReport($call, await $request);
  }

  $async.Future<$0.ReportGenerationResponse> generateReport(
      $grpc.ServiceCall call, $0.ReportGenerationRequest request);
}
