import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../admod_handle.dart';
import '../audio_player.dart';
import '../core/assets/app_assets.dart';
import '../core/common/app_func.dart';
import '../core/common/imagehelper.dart';
import '../core/model/music_model.dart';
import '../core/theme/textstyles.dart';
import '../utils/app_loading.dart';
import '../vibrator_manage.dart';
import '../routes/app_pages.dart';
import '../utils/touchable.dart';

class ItemMusicList extends StatelessWidget {
  ItemMusicList({Key? key, this.musicModel, this.controller, this.index})
      : super(key: key);
  MusicModel? musicModel;
  dynamic controller;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onTap: () async {
        // show ads
        if(musicModel?.isPremium == true){
          Get.toNamed(Routes.PREMIUM);
          return;
        }
        controller?.changeSelectedMusic(index ?? 0);
        musicModel?.onTab?.call();
        AudioPlayerVibration().currentUrl = musicModel?.url ??
            "https://storage.googleapis.com/vibrate/Autumn%20In%20My%20Heart.mp3";
        AudioPlayerVibration().playAudio(title: musicModel?.title ?? '');
      },
      child: Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border:
            Border(bottom: BorderSide(color: Colors.white38, width: 0.5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: ImageHelper.loadFromAsset(
                  musicModel?.thumb ?? AppAssets.img1,
                  fit: BoxFit.cover),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      musicModel?.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.caption.regular
                          .setColor(Colors.white)
                          .setFontWeight(FontWeight.w500),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, left: 5),
                      width: 40,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "${musicModel?.size} MB",
                          style: TextStyles.defaultStyle
                              .setColor(Colors.black)
                              .setTextSize(9),
                        ),
                      ),
                    ),
                  ],
                )),
            if(musicModel?.isPremium == true)
              ImageHelper.loadFromAsset(AppAssets.icPremium,
                  width: 20, height: 20,tintColor: Colors.lime),
            SizedBox(width: 10,),
            Icon(
              (musicModel?.isSelected ?? false)
                  ? Icons.pause_circle
                  : Icons.play_circle,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
