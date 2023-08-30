import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_app_vibrator_strong/ad_manager.dart';

enum AdLoadState { notLoaded, loading, loaded }

class ApplovinManager {
  static final ApplovinManager _singleton = ApplovinManager._internal();

  factory ApplovinManager() {
    return _singleton;
  }

  ApplovinManager._internal();

  // Create states
  var isInitialized = false;
  var interstitialLoadState = AdLoadState.notLoaded;
  var interstitialRetryAttempt = 0;
  var rewardedAdLoadState = AdLoadState.notLoaded;
  var rewardedAdRetryAttempt = 0;
  var isProgrammaticBannerCreated = false;
  var isProgrammaticBannerShowing = false;
  var isWidgetBannerShowing = false;
  var isProgrammaticMRecCreated = false;
  var isProgrammaticMRecShowing = false;
  var isWidgetMRecShowing = false;

  var statusText = "";

  Future<void> showAdIfReady() async {
    if (!isInitialized) {
      return;
    }
    bool isReady =
        (await AppLovinMAX.isAppOpenAdReady(AdManager.openAppAdUnitId))!;
    if (isReady) {
      AppLovinMAX.showAppOpenAd(AdManager.openAppAdUnitId);
    } else {
      AppLovinMAX.loadAppOpenAd(AdManager.openAppAdUnitId);
    }
  }

  // NOTE: Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initializePlugin() async {
    logStatus("Initializing SDK...");

    Map? configuration = await AppLovinMAX.initialize(AdManager.sdkKey);
    if (configuration != null) {
      isInitialized = true;
      logStatus("SDK Initialized: $configuration");
    }
  }

  void initReward() {
    AppLovinMAX.setRewardedAdListener(
        RewardedAdListener(onAdLoadedCallback: (ad) {
          rewardedAdLoadState = AdLoadState.loaded;

          // Rewarded ad is ready to be shown. AppLovinMAX.isRewardedAdReady(_rewarded_ad_unit_id) will now return 'true'
          logStatus('Rewarded ad loaded from ${ad.networkName}');

          // Reset retry attempt
          rewardedAdRetryAttempt = 0;
        }, onAdLoadFailedCallback: (adUnitId, error) {
          rewardedAdLoadState = AdLoadState.notLoaded;

          // Rewarded ad failed to load
          // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
          rewardedAdRetryAttempt = rewardedAdRetryAttempt + 1;

          int retryDelay = pow(2, min(6, rewardedAdRetryAttempt)).toInt();
          logStatus(
              'Rewarded ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

          Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
            AppLovinMAX.loadRewardedAd(AdManager.rewardedAdUnitId);
          });
        }, onAdDisplayedCallback: (ad) {
          logStatus('Rewarded ad displayed');
        }, onAdDisplayFailedCallback: (ad, error) {
          rewardedAdLoadState = AdLoadState.notLoaded;
          logStatus(
              'Rewarded ad failed to display with code ${error.code} and message ${error.message}');
        }, onAdClickedCallback: (ad) {
          logStatus('Rewarded ad clicked');
        }, onAdHiddenCallback: (ad) {
          rewardedAdLoadState = AdLoadState.notLoaded;
          logStatus('Rewarded ad hidden');
        }, onAdReceivedRewardCallback: (ad, reward) {
          logStatus('Rewarded ad granted reward');
        }, onAdRevenuePaidCallback: (ad) {
          logStatus('Rewarded ad revenue paid: ${ad.revenue}');
        }));
  }

  void initAppOpen(){
      AppLovinMAX.setAppOpenAdListener(AppOpenAdListener(
        onAdLoadedCallback: (ad) {},
        onAdLoadFailedCallback: (adUnitId, error) {},
        onAdDisplayedCallback: (ad) { },
        onAdDisplayFailedCallback: (ad, error) {
          AppLovinMAX.loadAppOpenAd(AdManager.openAppAdUnitId);
        },
        onAdClickedCallback: (ad) {},
        onAdHiddenCallback: (ad) {
          AppLovinMAX.loadAppOpenAd(AdManager.openAppAdUnitId);
        },
        onAdRevenuePaidCallback: (ad) {},
      ));

      AppLovinMAX.loadAppOpenAd(AdManager.openAppAdUnitId);
  }

  void initInter(){
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        interstitialLoadState = AdLoadState.loaded;

        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        logStatus('Interstitial ad loaded from ${ad.networkName}');

        // Reset retry attempt
        interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        interstitialLoadState = AdLoadState.notLoaded;

        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        interstitialRetryAttempt = interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, interstitialRetryAttempt)).toInt();
        logStatus(
            'Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(AdManager.interstitialAdUnitId);
        });
      },
      onAdDisplayedCallback: (ad) {
        logStatus('Interstitial ad displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        interstitialLoadState = AdLoadState.notLoaded;
        logStatus(
            'Interstitial ad failed to display with code ${error.code} and message ${error.message}');
      },
      onAdClickedCallback: (ad) {
        logStatus('Interstitial ad clicked');
      },
      onAdHiddenCallback: (ad) {
        interstitialLoadState = AdLoadState.notLoaded;
        logStatus('Interstitial ad hidden');
      },
      onAdRevenuePaidCallback: (ad) {
        logStatus('Interstitial ad revenue paid: ${ad.revenue}');
      },
    ));

  }

  void initBanner(){
    print("initn banner");
    AppLovinMAX.setBannerListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      logStatus('Banner ad loaded from ${ad.networkName}');
    }, onAdLoadFailedCallback: (adUnitId, error) {
      logStatus(
          'Banner ad failed to load with error code ${error.code} and message: ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('Banner ad clicked');
    }, onAdExpandedCallback: (ad) {
      logStatus('Banner ad expanded');
    }, onAdCollapsedCallback: (ad) {
      logStatus('Banner ad collapsed');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('Banner ad revenue paid: ${ad.revenue}');
    }));
  }

  String getInterstitialButtonTitle() {
    if (interstitialLoadState == AdLoadState.notLoaded) {
      return "Load Interstitial";
    } else if (interstitialLoadState == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Interstitial"; // adLoadState.loaded
    }
  }

  String getRewardedButtonTitle() {
    if (rewardedAdLoadState == AdLoadState.notLoaded) {
      return "Load Rewarded Ad";
    } else if (rewardedAdLoadState == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Rewarded Ad"; // adLoadState.loaded
    }
  }

  String getProgrammaticBannerButtonTitle() {
    return isProgrammaticBannerShowing
        ? 'Hide Programmatic Banner'
        : 'Show Programmatic Banner';
  }

  String getWidgetBannerButtonTitle() {
    return isWidgetBannerShowing ? 'Hide Widget Banner' : 'Show Widget Banner';
  }

  String getProgrammaticMRecButtonTitle() {
    return isProgrammaticMRecShowing
        ? 'Hide Programmatic MREC'
        : 'Show Programmatic MREC';
  }

  String getWidgetMRecButtonTitle() {
    return isWidgetMRecShowing ? 'Hide Widget MREC' : 'Show Widget MREC';
  }

  void logStatus(String status) {
    /// ignore: avoid_print
    print(status);
    statusText = status;
  }
}
