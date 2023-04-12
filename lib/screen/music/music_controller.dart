import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:get/get.dart';

import '../../audio_player.dart';
import '../../core/assets/app_assets.dart';
import '../../core/model/music_model.dart';

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
        isPremium: true),
    MusicModel(
        title: 'Miss You I So Much',
        path: AppAssets.missYouISoMuch,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'River Flows In You',
        path: AppAssets.riverFlowsInYou,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Romeo Juliette',
        path: AppAssets.romeoJuliette,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Secret Garden',
        path: AppAssets.secretGarden,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Song From Secret Garden',
        path: AppAssets.songFromSecretGarden,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'The Day Dream',
        path: AppAssets.theDayDream,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Music Cover 1',
        path: AppAssets.musicCover1,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Music Cover 2',
        path: AppAssets.mucsicCover2,
        onTab: () {},
        isSelected: false,
        isPremium: true),
    MusicModel(
        title: 'Music Cover 3',
        path: AppAssets.musicCover3,
        onTab: () {},
        isSelected: false,
        isPremium: true),
  ].obs;

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
