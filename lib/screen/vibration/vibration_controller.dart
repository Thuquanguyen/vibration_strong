import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';
import '../../ad_manager.dart';
import '../../admod_handle.dart';
import '../../ads/app_lifecircle_factory.dart';
import '../../ads/open_app_ads_manage.dart';
import '../../audio_player.dart';
import '../../core/assets/app_assets.dart';
import '../../core/model/music_model.dart';
import '../../core/model/vibration_model.dart';
import '../../core/service/notification_service.dart';
import '../../vibrator_manage.dart';

import '../../language/i18n.g.dart';

class VibrationController extends BaseController {
  RxList<VibrationModel> vibrations = <VibrationModel>[
    VibrationModel(
        title: I18n().sunnyStr.tr,
        icon: AppAssets.icSunny,
        onTap: () {
          Vibration.vibrate(
              pattern: [100, 8000, 100, 8000, 100, 8000, 100, 8000],
              intensities: [0, 255],
              repeat: 1,
              amplitude: 255);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().heartStr.tr,
        icon: AppAssets.icHeart,
        onTap: () {
          Vibration.vibrate(pattern: [
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40
          ], intensities: [
            1,
            255
          ], repeat: 1, amplitude: 128);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().waveStr.tr,
        icon: AppAssets.icWave,
        onTap: () {
          Vibration.vibrate(
              pattern: [100, 50, 100, 200, 100, 500, 100, 2000],
              intensities: [1, 128],
              repeat: 1,
              amplitude: 128);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().magicStr.tr,
        icon: AppAssets.icMagic,
        onTap: () {
          Vibration.vibrate(pattern: [
            100,
            20,
            50,
            200,
            10,
            500,
            100,
            10,
            100,
            2000,
            100,
            2000,
            100,
            2000,
            100,
            2000
          ], intensities: [
            1,
            255
          ], repeat: 1, amplitude: 20);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().dryStr.tr,
        icon: AppAssets.icDry,
        onTap: () {
          Vibration.vibrate(pattern: [
            30,
            40,
            30,
            40,
            30,
            40,
            30,
            40,
            30,
            40,
            30,
            40,
            30,
            40,
            30,
            40,
            30,
            40
          ], intensities: [
            1,
            255
          ], repeat: 1, amplitude: 255);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().expandStr.tr,
        icon: AppAssets.icExpand,
        onTap: () {
          Vibration.vibrate(pattern: [
            100,
            500,
            100,
            1000,
            100,
            2000,
            100,
            3000,
            100,
            4000,
            100,
            5000,
            100,
            6000,
            100,
            7000,
            100,
            8000
          ], intensities: [
            1,
            255
          ], repeat: 1, amplitude: 255);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().refreshStr.tr,
        icon: AppAssets.icRefresh,
        onTap: () {
          Vibration.vibrate(
              pattern: [50, 80, 50, 80, 50, 80, 50, 80],
              intensities: [0, 255],
              repeat: 1,
              amplitude: 255);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().breezeStr.tr,
        icon: AppAssets.icBreeze,
        onTap: () {
          Vibration.vibrate(pattern: [
            100,
            80,
            100,
            80,
            100,
            80,
            100,
            80,
            100,
            80,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40,
            100,
            40
          ], intensities: [
            1,
            255
          ], repeat: 1, amplitude: 128);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().riseStr.tr,
        icon: AppAssets.icRise,
        onTap: () {
          Vibration.vibrate(pattern: [
            50,
            50,
            50,
            50,
            50,
            50,
            100,
            2000,
            50,
            50,
            50,
            50,
            50,
            50,
            50,
            50,
            100,
            2000,
            50,
            50,
            50,
            50,
            50,
            50,
            50,
            50,
            100,
            2000,
            50,
            50,
            50,
            50,
            50,
            50,
            50,
            50,
            100,
            2000,
            50,
            50,
            50,
            50,
            50,
            50,
            50,
            50
          ], intensities: [
            1,
            10
          ], repeat: 1, amplitude: 10);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().dramaticStr.tr,
        icon: AppAssets.icDrammatic,
        onTap: () {
          Vibration.vibrate(pattern: [
            50,
            4000,
            50,
            50,
            50,
            4000,
            50,
            50,
            50,
            4000,
            50,
            50,
            50,
            50,
            4000,
            50,
            50,
            50,
            4000,
            50,
            4000
          ], intensities: [
            1,
            255
          ], repeat: 1, amplitude: 128);
        },
        isPremium: false,
        isSelected: false),
    VibrationModel(
        title: I18n().heavyStr.tr,
        icon: AppAssets.icHeavy,
        onTap: () {
          Vibration.vibrate(pattern: [
            50,
            40,
            50,
            40,
            50,
            40,
            50,
            40,
            50,
            40,
            50,
            40,
            50,
            40,
            50,
            40,
            50,
            40,
            50,
            40
          ], intensities: [
            1,
            10
          ], repeat: 1, amplitude: 10);
        },
        isPremium: true,
        isSelected: false),
    VibrationModel(
        title: I18n().snowStr.tr,
        icon: AppAssets.icSnow,
        onTap: () {
          Vibration.vibrate(
              pattern: [10, 60, 10, 10, 120, 10, 120, 10, 120, 10],
              intensities: [1, 255],
              repeat: 1,
              amplitude: 128);
        },
        isPremium: true,
        isSelected: false),
    VibrationModel(
        title: I18n().tingleStr.tr,
        icon: AppAssets.icTingle,
        onTap: () {
          Vibration.vibrate(pattern: [
            120,
            60,
            120,
            40,
            120,
            60,
            120,
            40,
            120,
            60,
            120,
            40,
            120,
            1000,
            120,
            60,
            120,
            40,
            120,
            60,
            120,
            40,
            120,
            60,
            120,
            2000,
            120,
            60,
            120,
            40,
            120,
            1000
          ], intensities: [
            1,
            255
          ], repeat: 1, amplitude: 128);
        },
        isPremium: true,
        isSelected: false),
    VibrationModel(
        title: I18n().dottedStr.tr,
        icon: AppAssets.icDotted,
        onTap: () {
          Vibration.vibrate(pattern: [
            50,
            500,
            50,
            500,
            50,
            500,
            50,
            500,
            50,
            500,
            50,
            500,
            50,
            500,
            50,
            500,
            50,
            500
          ], intensities: [
            1,
            10
          ], repeat: 1, amplitude: 10);
        },
        isPremium: true,
        isSelected: false),
    VibrationModel(
        title: I18n().warnStr.tr,
        icon: AppAssets.icWarn,
        onTap: () {
          Vibration.vibrate(
              pattern: [50, 50, 50, 50],
              intensities: [1, 255],
              repeat: 1,
              amplitude: 128);
        },
        isPremium: true,
        isSelected: false),
  ].obs;

  List<String> backgrounds = [
    AppAssets.imgSunny,
    AppAssets.imgHeart,
    AppAssets.imgWave,
    AppAssets.imgMagic,
    AppAssets.imgDry,
    AppAssets.imgExpand,
    AppAssets.imgRefresh,
    AppAssets.imgBreeze,
    AppAssets.imgRise,
    AppAssets.imgDramatic,
    AppAssets.imgHeavy,
    AppAssets.imgSnow,
    AppAssets.imgTingle,
    AppAssets.imgDotted,
    AppAssets.imgWarn,
  ];

  RxString song = I18n().singMySongStr.tr.obs;
  RxString backgroundColor = ''.obs;

  RxDouble progress = 0.0.obs;
  RxDouble initValue = 0.0.obs;
  RxBool isLoadAds = false.obs;

  RxInt indexOld = 0.obs;

  getTitle(double value) {
    if (value < 500) {
      return I18n().lowStr.tr;
    } else if (value >= 500 && value < 1000) {
      return I18n().mediumStr.tr;
    } else {
      return I18n().highStr.tr;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    NotificationService().showNotification();
    if(AdmodHandle().ads.isLimit == false){
      AdmodHandle().loadAdInter();
      AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
      AppLifecycleReactor(appOpenAdManager: appOpenAdManager)
          .listenToAppStateChanges();
    }
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeSelected(int index) {
    for (int i = 0; i < vibrations.length; i++) {
      vibrations[i].isSelected = false;
    }
    vibrations[index].isSelected = true;
    backgroundColor.value = backgrounds[index];
    indexOld.value = index;
    vibrations.refresh();
  }
}
