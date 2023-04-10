// ignore_for_file: file_names

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../common/app_func.dart';

// ignore: avoid_classes_with_only_static_members
class SharePreferencesHelper {
  static const String _prefix = 'vibration_';

  static Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //Shared prefences
  static Future setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_prefix$key', value);
  }

  static Future setDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$_prefix$key', value);
  }

  static Future setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    print('$_prefix$key');
    await prefs.setBool('$_prefix$key', value);
  }

  static Future setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_prefix$key', value);
  }

  static Future setStringList(String key, List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('$_prefix$key', values);
  }

  static Future setFcmTopics(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fcm_topics', values.join("||"));
    print('TOPICS: $values');
  }

  static Future<dynamic> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_prefix$key');
  }

  static Future setSessionToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_token', token);
  }

  static Future<String?> getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getString('session_token');
      if (value != null) {
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getInt('$_prefix$key');
      if (value != null) {
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future setCurrentUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    // LocalStorageHelper._prefix = username;
    Logger.debug('[POSSY] SET CURRENT USER TO $username');
    await prefs.setString('possy_current_user', username);
  }

  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getString('possy_current_user');
      Logger.debug('[POSSY] CURRENT USER IS $value');
      if (value != null) {
        // LocalStorageHelper._prefix = value;
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future setCurrentFitbit(String fitbit) async {
    final prefs = await SharedPreferences.getInstance();
    // LocalStorageHelper._prefix = username;
    Logger.debug('[POSSY] SET CURRENT FIBIT TO $fitbit');
    await prefs.setString('possy_current_fitbit', fitbit);
  }

  static Future<String?> getCurrentFitbit() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getString('possy_current_fitbit');
      Logger.debug('[POSSY] CURRENT FIBIT IS $value');
      if (value != null) {
        return value;
      }
    } catch (e) {
      Logger.debug('[POSSY] CURRENT FIBIT err $e');
      rethrow;
    }
    return null;
  }

  static Future setCurrentProfile(String username) async {
    final prefs = await SharedPreferences.getInstance();
    // LocalStorageHelper._prefix = username;
    Logger.debug('[POSSY] SET CURRENT PROFILE TO $username');
    await prefs.setString('possy_current_profile', username);
  }

  static Future<String?> getCurrentProfile() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getString('possy_current_profile');
      if (value != null) {
        Logger.debug('[POSSY] CURRENT PROFILE IS $value');
        // LocalStorageHelper._prefix = value;
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future setCurrentUserRank(String username) async {
    final prefs = await SharedPreferences.getInstance();
    // LocalStorageHelper._prefix = username;
    Logger.debug('[POSSY] SET CURRENT USER RANK TO $username');
    await prefs.setString('possy_current_user_rank', username);
  }

  static Future<String?> getCurrentUserRank() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getString('possy_current_user_rank');
      if (value != null) {
        Logger.debug('[POSSY] CURRENT USER RANK IS $value');
        // LocalStorageHelper._prefix = value;
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future saveUsers(String users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('possy_list_users', users);
  }

  static Future<String> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getString('possy_list_users');
      if (value != null) {
        return value;
      }
    } catch (e) {}
    return '[]';
  }

  static Future<String> getTimeInstallApp() async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      final time = _prefs.getString('time_install_app');
      if (time != null) {
        return time;
      } else {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        final time = DateTime.now().millisecondsSinceEpoch.toString();
        await _prefs.setString('time_install_app', time);
        return time;
      }
    } catch (e) {
      Logger.error('error = $e');
    }
    return 'none';
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getDouble('$_prefix$key');
      if (value != null) {
        return value;
      }
    } catch (e) {}
    return null;
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print('$_prefix$key');
    try {
      final value = prefs.getBool('$_prefix$key');
      Logger.debug('value = $value');
      if (value != null) {
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getString('$_prefix$key');
      if (value != null) {
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<List<String>?> getFcmTopics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString('fcm_topics');
      if (value != null) {
        return value.split('||');
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final value = prefs.getStringList('$_prefix$key');
      if (value != null) {
        return value;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$key');
  }

  //Write and read file
  static late String _fileName;

  static String get _getFileName {
    return _fileName;
  }

  static void _setFileName(String filename) {
    _fileName = filename;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_getFileName.txt');
  }

  static Future<File> writeToFile(String fileName, dynamic data) async {
    _setFileName(fileName);
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$data');
  }

  static Future<String> readFromFile(String filename) async {
    try {
      _setFileName(filename);
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      Logger.debug(contents);
      return contents;
    } catch (e) {
      // If encountering an error, return ""
      return '';
    }
  }

  //SQLite
  static late String _databasebName = '';

  static late String _tableName = '';

  static late String _arguments = '';

  static late int _sqliteVersion = -1;

  static bool _databaseCreated() {
    if (_databasebName == '' || _tableName == '' || _sqliteVersion == -1) {
      return false;
    } else {
      return true;
    }
  }

  //Create a table in SQLite
  static Future<Database> createDatabase(
      String db, String table, String arg, int version) async {
    final String path = await getDatabasesPath();
    _databasebName = db;
    _tableName = table;
    _arguments = arg;
    _sqliteVersion = version;
    return openDatabase(join(path, '$db.db'),
        onCreate: (database, version) async {
      await database.execute(
        arg,
      );
    }, version: version);
  }

  static Future<Database?> _initializeDB() async {
    if (!_databaseCreated()) {
      return null;
    }
    final String path = await getDatabasesPath();
    return openDatabase(join(path, '$_databasebName.db'),
        onCreate: (database, version) async {
      await database.execute(
        _arguments,
      );
    }, version: _sqliteVersion);
  }

  //Saving data in SQLite
  static Future<int> insertRow(String table, List<dynamic> dataList) async {
    int result = 0;
    final Database? db = await _initializeDB();
    if (db == null) {
      Logger.debug('null');
      return -1;
    } else {
      for (var user in dataList) {
        result = await db.insert(table, user.toMap());
      }
      return result;
    }
  }

}
