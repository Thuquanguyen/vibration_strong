import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../audio_player.dart';
import '../../core/assets/app_assets.dart';
import '../../core/base/base_controller.dart';
import '../../core/model/music_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SleepController extends BaseController {
  RxList<MusicModel> listMusics = [
    MusicModel(
        title: 'The Cradle of Your Soul',
        url:
            "https://storage.googleapis.com/sleep_music/%20The%20Cradle%20of%20Your%20Soul.mp3",
        onTab: () {},
        isSelected: false,
        size: 5.4,
        thumb: AppAssets.sleep1,
        isPremium: false),
    MusicModel(
        title: 'Bathroom - Chill Background Music',
        onTab: () {},
        url:
            "https://storage.googleapis.com/sleep_music/Bathroom%20-%20Chill%20Background%20Music.mp3",
        isSelected: false,
        size: 7.4,
        thumb: AppAssets.sleep2,
        isPremium: false),
    MusicModel(
        title: 'Believe in Miracle by PrabajithK',
        onTab: () {},
        url:
            "https://storage.googleapis.com/sleep_music/Believe%20in%20Miracle%20by%20PrabajithK.mp3",
        isSelected: false,
        size: 3.7,
        thumb: AppAssets.sleep3,
        isPremium: true),
    MusicModel(
        title: 'Cheerful Cinematic Song (without solo guitar)',
        onTab: () {},
        url:
            "https://storage.googleapis.com/sleep_music/Cheerful%20Cinematic%20Song%20(without%20solo%20guitar).mp3",
        isSelected: false,
        size: 8.8,
        thumb: AppAssets.sleep4,
        isPremium: true),
    MusicModel(
        title: 'Chill Lofi Song',
        onTab: () {},
        url:
            "https://storage.googleapis.com/sleep_music/Chill%20Lofi%20Song.mp3",
        isSelected: false,
        size: 2.3,
        thumb: AppAssets.sleep5,
        isPremium: true),
    MusicModel(
        title: 'Chill Sleep lofi background music for video',
        onTab: () {},
        thumb: AppAssets.sleep6,
        isSelected: false,
        url:
            "https://storage.googleapis.com/sleep_music/Chill%20Sleep%20lofi%20background%20music%20for%20video.mp3",
        size: 6.1,
        isPremium: true),
    MusicModel(
        title: 'Emotional Cinematic Background Music',
        onTab: () {},
        thumb: AppAssets.sleep7,
        url:
            "https://storage.googleapis.com/sleep_music/Emotional%20Cinematic%20Background%20Music.mp3",
        isSelected: false,
        size: 4.6,
        isPremium: true),
    MusicModel(
        title: 'Forest Lullaby',
        onTab: () {},
        thumb: AppAssets.sleep8,
        isSelected: false,
        url: "https://storage.googleapis.com/sleep_music/Forest%20Lullaby.mp3",
        size: 4.2,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.sleep9,
        title: 'Just Relax',
        onTab: () {},
        isSelected: false,
        url: "https://storage.googleapis.com/sleep_music/Just%20Relax.mp3",
        size: 4.9,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.sleep10,
        title: 'Moody Lofi Song.mp3',
        onTab: () {},
        isSelected: false,
        url:
            "https://storage.googleapis.com/sleep_music/Moody%20Lofi%20Song.mp3",
        size: 5.9,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.sleep11,
        title: 'Relax in the Forest background music for video',
        onTab: () {},
        isSelected: false,
        url:
            "https://storage.googleapis.com/sleep_music/Relax%20in%20the%20Forest%20background%20music%20for%20video.mp3",
        size: 6.0,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.sleep12,
        title: 'Slow Motion',
        onTab: () {},
        url: "https://storage.googleapis.com/sleep_music/Slow%20Motion.mp3",
        isSelected: false,
        size: 4.1,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.sleep13,
        title: 'The Longest Night Of This Winter',
        onTab: () {},
        url:
            "https://storage.googleapis.com/sleep_music/The%20Longest%20Night%20Of%20This%20Winter.mp3",
        isSelected: false,
        size: 10.6,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.sleep14,
        title: 'The first star -Calm Relaxing Piano Solo Music',
        onTab: () {},
        url:
            "https://storage.googleapis.com/sleep_music/The%20first%20star%20-Calm%20Relaxing%20Piano%20Solo%20Music.mp3",
        isSelected: false,
        size: 5.8,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.sleep5,
        title: 'Twinkle Like a Star',
        onTab: () {},
        url:
            "https://storage.googleapis.com/sleep_music/Twinkle%20Like%20a%20Star.mp3",
        isSelected: false,
        size: 3.9,
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
