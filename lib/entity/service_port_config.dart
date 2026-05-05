/// Entity for setting service ports, connection ips and service names.
class ServicePortConfig {
  final String name;
  final String ip;
  final int port;

  /// Default constructor for the ServicePortConfig
  const ServicePortConfig({
    this.name = "default_service",
    this.ip = "127.0.0.1",
    this.port = 50051,
  });

  /// Deserialize from Json
  factory ServicePortConfig.fromJson(Map<String, dynamic> json) {
    return ServicePortConfig(
      name: json['name'] as String,
      ip: json['ip'] as String,
      port: json['port'] as int,
    );
  }

  /// Serialize to Json
  Map<String, dynamic> toJson() => {'name': name, 'ip': ip, 'port': port};

  /// Creates a new instance if only one or more fields are updated.
  ServicePortConfig copyWith({
    String? name,
    String? ip,
    int? port,
  }) {
    return ServicePortConfig(
      name: name ?? this.name,
      ip: ip ?? this.ip,
      port: port ?? this.port,
    );
  }

}


