part of 'app_func.dart';

class Logger {
  static const bool isLog = false;
  static final int level = Type.DEBUG.index;
  static const tag = 'Reader ConsoleLog';
  static String? _appDocPath;

  static Future<String?> getAppDocPath() async {
    if (_appDocPath == null) {
      Directory appDocDir = await getTemporaryDirectory();
      _appDocPath = appDocDir.path;
    }
    return _appDocPath;
  }

  static Future<String?> getFilePath() async {
    String? path = await getAppDocPath();
    if (path != null) {
      return '$path/b2b.txt';
    }
    return null;
  }

  static void debug(dynamic msg, {bool logToFile = false}) {
    _log(Type.DEBUG, msg, logToFile: logToFile);
  }

  static void info(dynamic msg, {bool logToFile = false}) {
    _log(Type.INFO, msg, logToFile: logToFile);
  }

  static void warning(dynamic msg, {bool logToFile = false}) {
    _log(Type.WARNING, msg, logToFile: logToFile);
  }

  static void error(dynamic msg, {bool logToFile = false}) {
    _log(Type.ERROR, msg, logToFile: logToFile);
  }

  static _log(Type type, dynamic msg, {bool logToFile = false}) async {
    try {
      if (isLog && type.index >= level) {
        final now = DateTime.now();
        String time =
            '${now.year}/${now.month}/${now.day} ${now.hour}:${now.minute}:${now.second}:${now.millisecond}';
        String? screen = Trace.current().frames[2].member?.split(".")[0];
        String? widget = Trace.current().frames[2].member?.split(".")[1];
        String prefix = '$tag - ${type.toString()} - $time - $screen - $widget';
        print("$prefix : $msg");
        if (logToFile) {
          String data = '[$time]: $msg\n\n';
        }
      }
    } catch (error) {
      if (isLog && type.index >= level) {
        print('$msg');
      }
    }
  }
}

enum Type {
  DEBUG,
  INFO,
  WARNING,
  ERROR,
}
