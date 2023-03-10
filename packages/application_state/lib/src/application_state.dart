import 'package:shared_preferences/shared_preferences.dart';

class StorageException implements Exception {
  final String message;

  StorageException(this.message);
}

class ApplicationState {
  late SharedPreferences? _sharedPrefs;

  factory ApplicationState({SharedPreferences? sharedPrefs}) =>
      ApplicationState._internal(sharedPrefs: sharedPrefs);

  ApplicationState._internal({sharedPrefs}) {
    _sharedPrefs = sharedPrefs;
  }

  static Future<ApplicationState> createInstance() async {
    var applicationState = ApplicationState._internal();
    await applicationState._load();
    return applicationState;
  }

  Future<void> _load() async {
    _sharedPrefs = _sharedPrefs ?? await SharedPreferences.getInstance();
  }

  Future<bool> setIsLoggedin(bool value) {
    return _sharedPrefs!.setBool(keyIsLoggedin, value);
  }

  Future<bool> getIsLoggedin() async {
    try {
      return _sharedPrefs!.getBool(keyIsLoggedin) ?? false;
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}

const String keyIsLoggedin = "Key_isLoggedin";
