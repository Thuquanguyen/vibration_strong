import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../ad_manager.dart';
import '../../core/base/base_controller.dart';
import '../../core/model/vibration_model.dart';
import '../../in_app_manage.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_utils.dart';
import '../information/information_screen.dart';
import '../not_vibration/not_vibration_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MoreController extends BaseController {
  List<VibrationModel> vibrations = [
    VibrationModel(
        iconData: Icons.info_outline,
        title: 'Information',
        onTap: () {
          goToScreen(InformationScreen());
        }),
    VibrationModel(
        iconData: Icons.warning,
        title: 'Not Vibrating?',
        onTap: () {
          goToScreen(NotVibrationScreen());
        }),
    VibrationModel(
        iconData: Icons.feedback_outlined,
        title: 'Send feedback',
        onTap: () async {
          final Email email = Email(
            body: 'Email body',
            subject: 'Vibration strong: Vibrator App',
            recipients: ['support.vibrater@gmail.com'],
            attachmentPaths: ['/path/to/attachment.zip'],
            isHTML: false,
          );
          await FlutterEmailSender.send(email);
        }),
    VibrationModel(
        iconData: Icons.restore,
        title: 'Restore Purchase',
        onTap: () {
          IAPConnection.instance.restorePurchases();
        }),
    VibrationModel(
        iconData: Icons.share,
        title: 'Share',
        onTap: () {
          Share.share(
              "https://play.google.com/store/apps/details?id=com.flutter.flutter_app_vibrator_strong&hl=en&gl=US",
              subject: "Vibration strong: Vibrator App");
        }),
  ];


  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  Rx<BannerAd> bannerAd = BannerAd(
      size: AdSize(width: 0, height: 0),
      adUnitId: AdManager.bannerAdUnitId,
      listener: BannerAdListener(),
      request: AdRequest())
      .obs;
  RxBool isLoadAds = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    loadBannerAds();
    loadInterstitialAd();
    loadRewardedAd();
    super.onInit();
  }

  handleReward(){
    rewardedAd?.show(onUserEarnedReward: (a,b){
      goToScreen(NotVibrationScreen());
    });
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
          print('Failed to load a banner ad: ${err.message}');
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
