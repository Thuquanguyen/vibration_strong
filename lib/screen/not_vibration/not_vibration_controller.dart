import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../core/base/base_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NotVibrationController extends BaseController {

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
    super.onInit();
  }

  void loadBannerAds() {
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
}
