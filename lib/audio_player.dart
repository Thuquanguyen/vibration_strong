import 'package:just_audio/just_audio.dart';

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

  void playAudio() async {
    String audioAsset = currentUrl;
    await player.setAsset(audioAsset);
    player.play();
    if(url.isEmpty){
      url = currentUrl;
    }
  }
}
