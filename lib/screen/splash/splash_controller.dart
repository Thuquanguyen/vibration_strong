import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:flutter_app_vibrator_strong/core/common/app_func.dart';
import 'package:flutter_app_vibrator_strong/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';
import '../../constants.dart';
import '../../core/local_storage/localStorageHelper.dart';
import '../../core/theme/dimens.dart';
import '../../in_app_manage.dart';
import 'package:intl/intl.dart';

class SplashController extends BaseController {

  @override
  void onInit() {
    // TODO: implement onInit
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    requestPermission();
    if (Get.context != null) {
      Dimens.init(Get.context!);
    }
    Vibration.vibrate(duration: 1000, amplitude: 255);
    checkDirect();
    super.onInit();
  }

  void checkDirect() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String? data = await SharePreferencesHelper.getString(KEY_PURCHASE);
    bool isWelcome = await SharePreferencesHelper.getBool(KEY_WELCOME) ?? false;
    if (data == null) {
      AppFunc.setTimeout(() {
        IAPConnection().isAvailable = false;
        Get.offAndToNamed(!isWelcome ? Routes.WELCOME : Routes.PREMIUM);
      }, 3000);
    } else {
      DateTime dateTime = dateFormat.parse(data ?? '');
      if (dateTime.isBefore(DateTime.now())) {
        AppFunc.setTimeout(() {
          IAPConnection().isAvailable = false;
          Get.offAndToNamed(Routes.PREMIUM);
        }, 3000);
      } else {
        AppFunc.setTimeout(() {
          IAPConnection().updateAvailable();
          Get.offAndToNamed(Routes.MAIN);
        }, 3000);
      }
    }
  }

  requestPermission() async {
    PermissionStatus status = await Permission.notification.request();
    print("status = ${status}");
    if (status.isGranted) {
      // notification permission is granted
    } else {
      // Open settings to enable notification permission
    }
  }
}
