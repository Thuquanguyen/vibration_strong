import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';

import 'screen/vibration/vibration_controller.dart';

class AudioPlayerVibration {
  static final AudioPlayerVibration _singleton =
  AudioPlayerVibration._internal();

  factory AudioPlayerVibration() {
    return _singleton;
  }

  AudioPlayerVibration._internal();

  final player = AudioPlayer();
  String url = '';
  String currentUrl = '';

  void stopAudio() async {
    if(player.playing){
      await player.pause();
      await player.stop();
      if(currentUrl != url && url.isNotEmpty){
        url = currentUrl;
        playAudio();
      }else{
        url = '';
        currentUrl = '';
      }
    }
  }

  void playAudio({String? title}) async {
    Get.find<VibrationController>().song.value = title ?? '';
    String audioAsset = currentUrl;
    await player.setUrl(audioAsset);
    player.play();
    if(url.isEmpty){
      url = currentUrl;
    }
  }
}
