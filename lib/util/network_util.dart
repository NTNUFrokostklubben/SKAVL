

import 'dart:io';

/// Commonly used utilities for networking operations.
class NetworkUtil {

  /// Checks if a port is in use by trying to connect
  static Future<bool> isPortInUse(int port) async {
    try {
      final socket = await Socket.connect('localhost', port, timeout: Duration(seconds: 1));
      socket.destroy();
      return true;
    } catch (_) {
      return false;
    }
  }
}