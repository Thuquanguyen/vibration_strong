import 'package:in_app_purchase/in_app_purchase.dart';

class VibratorManager {
  static final VibratorManager _singleton = VibratorManager._internal();

  VibratorManager._internal();

  factory VibratorManager() {
    return _singleton;
  }

  bool hasVibrator = true;

}
