import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../core/base/base_controller.dart';
import 'package:applovin_max/applovin_max.dart';

import '../../language/i18n.g.dart';

class WelcomeController extends BaseController {
  RxBool firstScreen = true.obs;
  Rx<PageController> controller = PageController().obs;
  RxInt pageIndex = 0.obs;
  List<String> listTitle = [I18n().vibrationStr.tr, I18n().relaxStr.tr, I18n().meditationStr.tr];

  List<String> listSubTitle = [
    I18n().bannerTitle1Str.tr,
    I18n().bannerTitle2Str.tr,
    I18n().bannerTitle3Str.tr
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
