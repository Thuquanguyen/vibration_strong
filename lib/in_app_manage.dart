import 'package:in_app_purchase/in_app_purchase.dart';

class IAPConnection {
  static InAppPurchase? _instance;
  static final IAPConnection _singleton = IAPConnection._internal();

  static set instance(InAppPurchase value) {
    _instance = value;
  }

  IAPConnection._internal();

  factory IAPConnection() {
    return _singleton;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }

  bool isAvailable = false;
  bool hasVibrator = true;

  void updateAvailable() {
    isAvailable = true;
  }
}
