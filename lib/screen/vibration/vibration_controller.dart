import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';
import '../../ad_manager.dart';
import '../../ads/app_lifecircle_factory.dart';
import '../../ads/open_app_ads_manage.dart';
import '../../audio_player.dart';
import '../../core/assets/app_assets.dart';
import '../../core/model/music_model.dart';
import '../../core/model/vibration_model.dart';
import '../../core/service/notification_service.dart';
import '../../in_app_manage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class VibrationController extends BaseController {
  RxList<VibrationModel> vibrations = <VibrationModel>[
    VibrationModel(
        title: 'Sunny',
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
        title: 'Heart',
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
        title: 'Wave',
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
        title: 'Magic',
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
        title: 'Dry',
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
        title: 'Expand',
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
        title: 'Refresh',
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
        title: 'Breeze',
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
        title: 'Rise',
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
        title: 'Dramatic',
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
        title: 'Heavy',
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
        title: 'Snow',
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
        title: 'Tingle',
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
        title: 'Dotted',
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
        title: 'Warn',
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

  RxString song = 'Sing my song'.obs;
  RxString backgroundColor = ''.obs;

  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  Rx<BannerAd> bannerAd = BannerAd(
      size: AdSize(width: 0, height: 0),
      adUnitId: AdManager.bannerAdUnitId,
      listener: BannerAdListener(),
      request: AdRequest())
      .obs;

  RxDouble progress = 0.0.obs;
  RxDouble initValue = 0.0.obs;
  RxBool isLoadAds = false.obs;

  getTitle(double value) {
    if (value < 500) {
      return 'Low';
    } else if (value >= 500 && value < 1000) {
      return 'Medium';
    } else {
      return 'High';
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    NotificationService().showNotification();
    loadBannerAds();
    loadInterstitialAd();
    loadRewardedAd();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    AppLifecycleReactor(appOpenAdManager: appOpenAdManager)
        .listenToAppStateChanges();
    super.onInit();
  }

  @override
  void dispose() {
    bannerAd.value.dispose();
    interstitialAd?.dispose();
    rewardedAd?.dispose();
    super.dispose();
  }

  void changeSelected(int index) {
    for (int i = 0; i < vibrations.length; i++) {
      vibrations[i].isSelected = false;
    }
    vibrations[index].isSelected = true;
    backgroundColor.value = backgrounds[index];
    vibrations.refresh();
  }

  Future<bool> checkPurchase() async {
    return await IAPConnection.instance.isAvailable();
  }

  void loadBannerAds(){
    BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd.value = ad as BannerAd;
          isLoadAds.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message} - ${ad.adUnitId}');
          ad.dispose();
        },
      ),
    ).load();
  }
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdManager.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedAd = null;
              loadRewardedAd();
            },
          );
          rewardedAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdManager.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              interstitialAd = null;
              loadInterstitialAd();
              print("onAdDismissedFullScreenContent");
            },
          );
          interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
}
