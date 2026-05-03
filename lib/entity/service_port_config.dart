
/// Entity for setting ports, connection ips and service names.
///
/// Used mostly for organizational purposes.
class ServicePortConfig {
  String _name = "default_service";
  String _ip = "127.0.0.1";
  String _port = "50051";



  String get name => _name;
  String get ip => _ip;
  String get port => _port;

  /// Sets the name for the service
  void setName(String name) {
    _name = name;
  }

  /// Sets the connection IP for the service
  void setIp(String ip) {
    _ip = ip;
  }

  /// Sets the port to connect to for the service
  void setPort(String port) {
    _port = port;
  }

}