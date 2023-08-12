import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../audio_player.dart';
import '../../core/assets/app_assets.dart';
import '../../core/base/base_controller.dart';
import '../../core/model/music_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MusicController extends BaseController {
  RxList<MusicModel> listMusics = [
    MusicModel(
        title: 'Autumn In My Heart',
        url:
            "https://storage.googleapis.com/vibrate/Autumn%20In%20My%20Heart.mp3",
        onTab: () {},
        isSelected: false,
        size: 1.1,
        thumb: AppAssets.img1,
        isPremium: false),
    MusicModel(
        title: 'Forever',
        onTab: () {},
        url:
            "https://storage.googleapis.com/vibrate/Forever.mp3",
        isSelected: false,
        size: 2.7,
        thumb: AppAssets.img2,
        isPremium: false),
    MusicModel(
        title: 'Fur Elise Various Artists',
        onTab: () {},
        url:
            "https://storage.googleapis.com/vibrate/Fur%20Elise%20Various%20Artists.mp3",
        isSelected: false,
        size: 3,
        thumb: AppAssets.img3,
        isPremium: false),
    MusicModel(
        title: 'Miss You I So Much',
        onTab: () {},
        url:
            "https://storage.googleapis.com/vibrate/Miss%20You%20I%20So%20Much.mp3",
        isSelected: false,
        size: 3.1,
        thumb: AppAssets.img4,
        isPremium: true),
    MusicModel(
        title: 'River Flows In You',
        onTab: () {},
        url:
            "https://storage.googleapis.com/vibrate/River%20Flows%20In%20You.mp3",
        isSelected: false,
        size: 2.9,
        thumb: AppAssets.img5,
        isPremium: true),
    MusicModel(
        title: 'Romeo Juliette',
        onTab: () {},
        isSelected: false,
        url:
            "https://storage.googleapis.com/vibrate/Romeo%20Juliette.mp3",
        size: 2.2,
        thumb: AppAssets.img6,
        isPremium: true),
    MusicModel(
        title: 'Secret Garden',
        onTab: () {},
        url:
            "https://storage.googleapis.com/vibrate/Secret%20Garden.mp3",
        isSelected: false,
        size: 2.7,
        thumb: AppAssets.img7,
        isPremium: true),
    MusicModel(
        title: 'Song From Secret Garden',
        onTab: () {},
        isSelected: false,
        url:
            "https://storage.googleapis.com/vibrate/Song%20From%20Secret%20Garden.mp3",
        size: 3.3,
        thumb: AppAssets.img8,
        isPremium: true),
    MusicModel(
        title: 'The Day Dream',
        onTab: () {},
        isSelected: false,
        url:
            "https://storage.googleapis.com/vibrate/The%20Day%20Dream.mp3",
        size: 3.1,
        thumb: AppAssets.img9,
        isPremium: true),
    MusicModel(
        title: 'Music Premium 1',
        onTab: () {},
        isSelected: false,
        url:
            "https://storage.googleapis.com/vibrate/Music%20Cover%201.mp3",
        size: 8.9,
        isPremium: true),
    MusicModel(
        title: 'Music Premium 2',
        onTab: () {},
        isSelected: false,
        url:
            "https://storage.googleapis.com/vibrate/Mucsic%20Cover%202.mp3",
        size: 3.7,
        thumb: AppAssets.img10,
        isPremium: true),
    MusicModel(
        title: 'Music Premium 3',
        onTab: () {},
        url:
            "https://storage.googleapis.com/vibrate/Music%20Cover%203.mp3",
        isSelected: false,
        size: 5.2,
        thumb: AppAssets.img11,
        isPremium: true),
  ].obs;

  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  Rx<BannerAd> bannerAd = BannerAd(
          size: AdSize(width: 0, height: 0),
          adUnitId: AdManager.bannerAdUnitId,
          listener: BannerAdListener(),
          request: AdRequest())
      .obs;
  Rx<BannerAd> bannerAdBottom = BannerAd(
          size: AdSize(width: 0, height: 0),
          adUnitId: AdManager.bannerAdUnitId,
          listener: BannerAdListener(),
          request: AdRequest())
      .obs;
  RxBool isLoadAds = false.obs;
  RxBool isLoadAdsBottom = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    loadBannerAds();
    loadBannerAdsBottom();
    loadInterstitialAd();
    loadRewardedAd();
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
          listMusics.refresh();
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  void loadBannerAdsBottom() {
    BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAdBottom.value = ad as BannerAd;
          isLoadAdsBottom.value = true;
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

  void changeSelectedMusic(int index) {
    AudioPlayerVibration().stopAudio();
    if (listMusics[index].isSelected == true) {
      listMusics[index].isSelected = false;
    } else {
      for (int i = 0; i < listMusics.length; i++) {
        listMusics[i].isSelected = false;
      }
      listMusics[index].isSelected = true;
    }
    listMusics.refresh();
  }
}
