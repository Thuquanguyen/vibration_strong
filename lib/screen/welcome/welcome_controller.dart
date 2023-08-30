import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../core/base/base_controller.dart';
import 'package:applovin_max/applovin_max.dart';

class WelcomeController extends BaseController {
  RxBool firstScreen = true.obs;
  Rx<PageController> controller = PageController().obs;
  RxInt pageIndex = 0.obs;
  List<String> listTitle = ["Vibration!", "Relax", "Meditation"];

  List<String> listSubTitle = [
    "Just perfect vibrator app massager with customizable strong vibration.",
    "The best and most relaxing massager",
    "Relax more with meditation music"
  ];

  Rx<MaxNativeAdViewController> nativeAdViewController =
      MaxNativeAdViewController().obs;
  static double kMediaViewAspectRatio = 4 / 3;

  RxString statusText = "".obs;

  RxDouble mediaViewAspectRatio = kMediaViewAspectRatio.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nativeAdViewController.value.loadAd();
    AppLovinMAX.loadInterstitial(AdManager.interstitialAdUnitId);
    super.onInit();
  }
}
