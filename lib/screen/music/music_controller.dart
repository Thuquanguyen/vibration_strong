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
        path: AppAssets.autumnInMyHeart,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'Forever',
        path: AppAssets.forever,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'Fur Elise Various Artists',
        path: AppAssets.furEliseVariousArtists,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'Miss You I So Much',
        path: AppAssets.missYouISoMuch,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'River Flows In You',
        path: AppAssets.riverFlowsInYou,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'Romeo Juliette',
        path: AppAssets.romeoJuliette,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'Secret Garden',
        path: AppAssets.secretGarden,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'Song From Secret Garden',
        path: AppAssets.songFromSecretGarden,
        onTab: () {},
        isSelected: false,
        isPremium: false),
    MusicModel(
        title: 'The Day Dream',
        path: AppAssets.theDayDream,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Music Premium 1',
        path: AppAssets.musicCover1,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Music Premium 2',
        path: AppAssets.mucsicCover2,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Music Premium 3',
        path: AppAssets.musicCover3,
        onTab: () {},
        isSelected: false,
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
