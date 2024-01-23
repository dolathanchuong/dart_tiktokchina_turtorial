import 'dart:io';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

// Create logs folder
var curPath = Directory.current.path;
var logPath = Directory('$curPath/logs');

class Log {
  Log() {
    // File naming
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd_HH:mm:ss');
    var logName = 'logs/${formatter.format(now)}.log';

    Logger.root
      ..level = Level.INFO
      ..onRecord.listen((LogRecord rec) {
        var message =
            '[${rec.time}] - [${rec.loggerName}] - [${rec.level}] - ${rec.message}';
        print(message);

        var file = File(logName);
        var sink = file.openWrite(mode: FileMode.append);
        sink.write('$message\n');
        sink.close();
      });
  }

  void debug(String message) {
    Logger.root.fine(message);
  }

  void info(String message) {
    Logger.root.info(message);
  }

  void warning(String message) {
    Logger.root.warning(message);
  }

  void error(String message) {
    Logger.root.severe(message);
  }
}
