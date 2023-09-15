import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_app_vibrator_strong/admod_handle.dart';
import 'package:flutter_app_vibrator_strong/core/assets/app_assets.dart';
import 'package:flutter_app_vibrator_strong/core/common/app_func.dart';
import 'package:flutter_app_vibrator_strong/core/common/imagehelper.dart';
import 'package:flutter_app_vibrator_strong/language/i18n.g.dart';

StreamSubscription? showLoadingTimeout;

void initLoadingStyle() {
  EasyLoading.instance
    // ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    // ..userInteractions = false
    // ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    // ..indicatorWidget = ImageHelper.loadAsset(AssetHelper.imgVPBankSplashLogo, width: 60, height: 40, fit: BoxFit.contain)
    ..customAnimation = CustomAnimation();
}

void showLoading({
  String? status,
  Widget? indicator,
  bool? dismissOnTap,
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.clear,
}) {
  EasyLoading.show(
      status: status,
      indicator: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            color: Colors.red,
          )),
      dismissOnTap: dismissOnTap,
      maskType: maskType);
}

void showLoadingAds() {
  if (AdmodHandle().isShowInter && !AdmodHandle().isShowDialog) {
    AdmodHandle().isShowInter = false;
    AdmodHandle().isShowDialog = true;
    Get.dialog(
      Container(
        color: Colors.black,
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: ImageHelper.loadFromAsset(AppAssets.imgAds,
                  width: 80,
                  height: 120,
                  tintColor: Colors.white,
                  fit: BoxFit.cover),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              I18n().loadAdsStr.tr,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  color: Colors.white70,
                ))
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      barrierColor: Colors.black, // Background color
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 400),
    );
    AppFunc.setTimeout(() {
      AdmodHandle().isShowInter = true;
      print("duration...");
    }, 10000);
  }
}

void hideLoadingAds() {
  if (AdmodHandle().isShowDialog) {
    AdmodHandle().isShowDialog = false;
    AppFunc.setTimeout(() {
      Get.back();
    }, 300);
  }
}

void hideLoading() {
  // loading.hide();
  if (showLoadingTimeout != null) {
    clearTimeout(showLoadingTimeout!);
    showLoadingTimeout = null;
  }
  // VPLoading().hideLoading();
  if (EasyLoading.isShow) {
    EasyLoading.dismiss();
  }
}

void clearTimeout(StreamSubscription subscription) {
  try {
    subscription.cancel();
  } catch (e) {}
}

StreamSubscription setTimeout(Function callback, int milliseconds) {
  final Future future = Future.delayed(Duration(milliseconds: milliseconds));
  return future.asStream().listen(
    (event) {},
    onDone: () {
      callback();
    },
  );
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
