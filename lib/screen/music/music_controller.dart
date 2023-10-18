import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../admod_handle.dart';
import '../../audio_player.dart';
import '../../core/assets/app_assets.dart';
import '../../core/base/base_controller.dart';
import '../../core/model/music_model.dart';
import '../../in_app_manage.dart';

class MusicController extends BaseController {
  RxList<MusicModel> listMusics = [
    MusicModel(
      title: 'Autumn In My Heart',
      url:
      "https://storage.googleapis.com/vibrate/Autumn%20In%20My%20Heart.mp3",
      onTab: () {},
      isSelected: false,
      size: 1.1,
      view: 1988,
      thumb: AppAssets.img1,
    ),
    MusicModel(
      title: 'Forever',
      onTab: () {},
      url: "https://storage.googleapis.com/vibrate/Forever.mp3",
      isSelected: false,
      size: 2.7,
      view: 1998,
      thumb: AppAssets.img2,
    ),
    MusicModel(
      title: 'Fur Elise Various Artists',
      onTab: () {},
      url:
      "https://storage.googleapis.com/vibrate/Fur%20Elise%20Various%20Artists.mp3",
      isSelected: false,
      size: 3,
      view: 256,
      thumb: AppAssets.img3,
    ),
    MusicModel(
      title: 'Miss You I So Much',
      onTab: () {},
      url:
      "https://storage.googleapis.com/vibrate/Miss%20You%20I%20So%20Much.mp3",
      isSelected: false,
      size: 3.1,
      view: 1711,
      thumb: AppAssets.img4,
    ),
    MusicModel(
      title: 'River Flows In You',
      onTab: () {},
      url:
      "https://storage.googleapis.com/vibrate/River%20Flows%20In%20You.mp3",
      isSelected: false,
      size: 2.9,
      view: 5822,
      thumb: AppAssets.img5,
    ),
    MusicModel(
        title: 'Romeo Juliette',
        onTab: () {},
        isSelected: false,
        url: "https://storage.googleapis.com/vibrate/Romeo%20Juliette.mp3",
        size: 2.2,
        view: 3511,
        thumb: AppAssets.img6,
        isPremium: true
    ),
    MusicModel(
        title: 'Secret Garden',
        onTab: () {},
        url: "https://storage.googleapis.com/vibrate/Secret%20Garden.mp3",
        isSelected: false,
        size: 2.7,
        view: 620,
        thumb: AppAssets.img7,
        isPremium: true
    ),
    MusicModel(
        title: 'Song From Secret Garden',
        onTab: () {},
        isSelected: false,
        url:
        "https://storage.googleapis.com/vibrate/Song%20From%20Secret%20Garden.mp3",
        size: 3.3,
        view: 955,
        thumb: AppAssets.img8,
        isPremium: true
    ),
    MusicModel(
        title: 'The Day Dream',
        onTab: () {},
        isSelected: false,
        url: "https://storage.googleapis.com/vibrate/The%20Day%20Dream.mp3",
        size: 3.1,
        view: 1554,
        thumb: AppAssets.img9,
        isPremium: true
    ),
    MusicModel(
      title: 'Music Premium 1',
      onTab: () {},
      isSelected: false,
      url: "https://storage.googleapis.com/vibrate/Music%20Cover%201.mp3",
      size: 8.9,
    ),
    MusicModel(
        title: 'Music Premium 2',
        onTab: () {},
        isSelected: false,
        url: "https://storage.googleapis.com/vibrate/Mucsic%20Cover%202.mp3",
        size: 3.7,
        view: 1024,
        thumb: AppAssets.img10,
        isPremium: true
    ),
    MusicModel(
        title: 'Music Premium 3',
        onTab: () {},
        url: "https://storage.googleapis.com/vibrate/Music%20Cover%203.mp3",
        isSelected: false,
        size: 5.2,
        view: 2165,
        thumb: AppAssets.img11,
        isPremium: true
    ),
  ].obs;

  RxBool isLoadAds = false.obs;
  RxBool isLoadAdsBottom = false.obs;
  RxInt indexOld = 0.obs;

  @override
  void onInit() {
    if(IAPConnection().isAvailable){
      for(int i = 0;i< listMusics.length;i++){
        listMusics[i].isPremium = false;
      }
      listMusics.refresh();
    }
    super.onInit();
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
    indexOld.value = index;
    listMusics.refresh();
  }
}
