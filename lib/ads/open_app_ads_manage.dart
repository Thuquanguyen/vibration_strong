import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad_manager.dart';

class AppOpenAdManager {
  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Load an AppOpenAd.
  void loadAd({bool isSplash = false,Function? callBack,Function? callbackFail}) {
    bool isLoaded = false;
    AppOpenAd.load(
      adUnitId: AdManager.openAppAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
          if(isSplash && !isLoaded){
            isLoaded = true;
            showAdIfAvailable(callback: (){
              callBack?.call();
            });
          }
        },
        onAdFailedToLoad: (error) {
          callbackFail?.call();
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable({Function? callback}) {
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      print('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    print("LOAD LOAD LOAD");
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        callback?.call();
      },
    );
    _appOpenAd!.show();
  }
}
