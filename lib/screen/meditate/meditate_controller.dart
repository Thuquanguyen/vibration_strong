import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../admod_handle.dart';
import '../../audio_player.dart';
import '../../core/assets/app_assets.dart';
import '../../core/base/base_controller.dart';
import '../../core/model/music_model.dart';
import '../../in_app_manage.dart';

class MeditateController extends BaseController {
  RxList<MusicModel> listMusics = [
    MusicModel(
      title: 'Mindfulness Relaxation & Meditation Music',
      url:
      "https://storage.googleapis.com/meditation_music/%20Mindfulness%20Relaxation%20%26%20Meditation%20Music.mp3",
      onTab: () {},
      isSelected: false,
      size: 7.3,
      view: 1175,
      thumb: AppAssets.mediation1,
    ),
    MusicModel(
      title: 'Inspired ambient',
      onTab: () {},
      url:
      "https://storage.googleapis.com/meditation_music/Inspired%20ambient.mp3",
      isSelected: false,
      size: 2.6,
      view: 1262,
      thumb: AppAssets.mediation2,
    ),
    MusicModel(
      title: 'Just Relax',
      onTab: () {},
      url: "https://storage.googleapis.com/meditation_music/Just%20Relax.mp3",
      isSelected: false,
      size: 4.9,
      view: 1025,
      thumb: AppAssets.mediation3,
    ),
    MusicModel(
      title: 'Lofi Study',
      onTab: () {},
      url: "https://storage.googleapis.com/meditation_music/Lofi%20Study.mp3",
      isSelected: false,
      size: 4.5,
      view: 657,
      thumb: AppAssets.mediation4,
    ),
    MusicModel(
      title: 'Moment',
      onTab: () {},
      url: "https://storage.googleapis.com/meditation_music/Moment.mp3",
      isSelected: false,
      size: 6.5,
      view: 388,
      thumb: AppAssets.mediation5,
    ),
    MusicModel(
        title: 'Nature',
        onTab: () {},
        isSelected: false,
        url: "https://storage.googleapis.com/meditation_music/Nature.mp3",
        size: 3.3,
        view: 2385,
        thumb: AppAssets.meditation6,
        isPremium: true
    ),
    MusicModel(
        title:
        'Peaceful Garden - Healing Light Piano for meditation, zen, landsca',
        onTab: () {},
        url:
        "https://storage.googleapis.com/meditation_music/Peaceful%20Garden%20-%20Healing%20Light%20Piano%20for%20meditation%2C%20zen%2C%20landsca.mp3",
        isSelected: false,
        size: 5.5,
        view: 1666,
        thumb: AppAssets.meditation7,
        isPremium: true
    ),
    MusicModel(
        title: 'Piano Moment',
        onTab: () {},
        isSelected: false,
        url: "https://storage.googleapis.com/meditation_music/Piano%20Moment.mp3",
        size: 8.3,
        view: 685,
        thumb: AppAssets.meditation8,
        isPremium: true
    ),
    MusicModel(
        title: 'Please Calm My Mind',
        onTab: () {},
        isSelected: false,
        url:
        "https://storage.googleapis.com/meditation_music/Please%20Calm%20My%20Mind.mp3",
        size: 5.3,
        view: 2151,
        thumb: AppAssets.meditation9,
        isPremium: true
    ),
    MusicModel(
        thumb: AppAssets.meditation10,
        title: 'Reflected Light',
        onTab: () {},
        isSelected: false,
        view: 1162,
        url:
        "https://storage.googleapis.com/meditation_music/Reflected%20Light.mp3",
        size: 6.9,
        isPremium: true
    ),
    MusicModel(
        thumb: AppAssets.meditation11,
        title: 'Relaxing',
        onTab: () {},
        isSelected: false,
        view: 969,
        url: "https://storage.googleapis.com/meditation_music/Relaxing.mp3",
        size: 2.2,
        isPremium: true
    ),
    MusicModel(
        thumb: AppAssets.meditation12,
        title: 'Slow Motion',
        onTab: () {},
        url: "https://storage.googleapis.com/meditation_music/Slow%20Motion.mp3",
        isSelected: false,
        size: 4.1,
        isPremium: true
    ),
    MusicModel(
        thumb: AppAssets.meditation13,
        title: 'The Cradle of Your Soul',
        onTab: () {},
        url:
        "https://storage.googleapis.com/meditation_music/The%20Cradle%20of%20Your%20Soul.mp3",
        isSelected: false,
        view: 256,
        size: 5.4,
        isPremium: true),
    MusicModel(
        thumb: AppAssets.meditation14,
        title: 'Tuesday (Glitch Soft Hip-hop)',
        onTab: () {},
        url:
        "https://storage.googleapis.com/meditation_music/Tuesday%20(Glitch%20Soft%20Hip-hop).mp3",
        isSelected: false,
        view: 365,
        size: 3.9,
        isPremium: true),
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
