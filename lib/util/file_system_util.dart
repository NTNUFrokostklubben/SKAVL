import 'dart:io';
import 'package:path/path.dart' as p;

/// Static methods for handling common file system operations
class FileSystemUtil {
  FileSystemUtil._();

  /// Opens file with platform specific file viewer for given path
  static Future<void> openFile(String path) async {
    if (Platform.isWindows) {
      await Process.start('explorer', [path], mode: ProcessStartMode.detached);
    } else if (Platform.isLinux) {
      await Process.start('xdg-open', [path], mode: ProcessStartMode.detached);
    } else if (Platform.isMacOS) {
      await Process.start('open', [path], mode: ProcessStartMode.detached);
    }
  }

  /// Opens platform specific file viewer for given path
  static Future<void> openDirectory(String path) async {
    final dir = File(path).existsSync() ? p.dirname(path) : path;

    if (Platform.isWindows) {
      await Process.start('explorer', [dir], mode: ProcessStartMode.detached);
    } else if (Platform.isLinux) {
      await Process.start('xdg-open', [dir], mode: ProcessStartMode.detached);
    } else if (Platform.isMacOS) {
      await Process.start('open', [dir], mode: ProcessStartMode.detached);
    }
  }
}
