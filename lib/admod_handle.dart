import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter_app_vibrator_strong/core/model/data_model.dart';

import 'ad_manager.dart';

class AdmodHandle {
  static final AdmodHandle _singleton = AdmodHandle._internal();

  AdmodHandle._internal();

  factory AdmodHandle() {
    return _singleton;
  }

  DataModel ads = DataModel();
  NativeAd? nativeAd;
  NativeAd? nativeAdSmall;
  NativeAd? nativeAdSmallWelcome;
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;
  BannerAd? bannerAd2;
  BannerAd? bannerAd3;
  BannerAd? bannerAd4;
  BannerAd? bannerAdLanguage;
  RxBool isLoadedBanner = false.obs;
  RxBool isLoadedBanner2 = false.obs;
  RxBool isLoadedBanner3 = false.obs;
  RxBool isLoadedBanner4 = false.obs;
  RxBool isLoadedBannerLanguage = false.obs;
  RxBool nativeAdIsLoaded = false.obs;
  RxBool nativeSmallAdIsLoaded = false.obs;
  RxBool nativeSmallWelcomAdIsLoaded = false.obs;

  bool isShowInter = true;
  bool isShowDialog = false;
  void loadAdBannerLanguage() {
    bannerAdLanguage = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoadedBannerLanguage.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
  void loadAdBanner() {
    bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoadedBanner.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
  void loadAdBanner2() {
    bannerAd2 = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoadedBanner2.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
  void loadAdBanner3() {
    bannerAd3 = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoadedBanner3.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
  void loadAdBanner4() {
    bannerAd4 = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoadedBanner4.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  void loadAdInter() {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  print("errorrr");
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  print("dsdsdsdsdsdsd");
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
            interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void loadAdNativeMedium() {
    nativeAd = NativeAd(
        adUnitId: AdManager.nativeAppAdUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            nativeAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            print('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.transparent,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.transparent,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  void loadAdNativeSmall() {
    nativeAdSmall = NativeAd(
        adUnitId: AdManager.nativeAppAdUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            nativeSmallAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            print('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
            templateType: TemplateType.small,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.transparent,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.transparent,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  void loadAdNativeSmallWelcom() {
    nativeAdSmallWelcome = NativeAd(
        adUnitId: AdManager.nativeAppAdUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            nativeSmallWelcomAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            print('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
            templateType: TemplateType.small,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.transparent,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.transparent,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }
}
