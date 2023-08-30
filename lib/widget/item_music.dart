import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../audio_player.dart';
import '../core/assets/app_assets.dart';
import '../core/common/app_func.dart';
import '../core/common/imagehelper.dart';
import '../core/model/music_model.dart';
import '../core/theme/textstyles.dart';
import '../in_app_manage.dart';
import '../routes/app_pages.dart';
import '../screen/music/music_controller.dart';
import '../screen/premium/premium_screen.dart';
import '../utils/app_utils.dart';
import '../utils/touchable.dart';

class ItemMusic extends StatelessWidget {
  ItemMusic({Key? key, this.musicModel, this.controller, this.index})
      : super(key: key);
  MusicModel? musicModel;
  dynamic controller;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onTap: () async {
        if (!IAPConnection().isAvailable && musicModel?.isPremium == true) {
          if (AudioPlayerVibration().currentUrl == musicModel?.url &&
              AudioPlayerVibration().player.playing) {
            AudioPlayerVibration().currentUrl = '';
            AudioPlayerVibration().stopAudio();
            controller?.changeSelectedMusic(index ?? 0);
          } else {
            Get.toNamed(Routes.PREMIUM);
          }
        } else {
          controller?.changeSelectedMusic(index ?? 0);
          musicModel?.onTab?.call();
          AudioPlayerVibration().currentUrl = musicModel?.url ??
              "https://storage.googleapis.com/vibrate/Autumn%20In%20My%20Heart.mp3";
          AudioPlayerVibration().playAudio(title: musicModel?.title ?? '');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImageHelper.loadFromAsset(
                    musicModel?.thumb ?? AppAssets.img1,
                    fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  width: 40,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "${musicModel?.size} MB",
                      style: TextStyles.defaultStyle
                          .setColor(Colors.white)
                          .setTextSize(9),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2)),
                  padding: EdgeInsets.all(8.w),
                  child: Center(
                    child: Icon(
                      (musicModel?.isSelected ?? false)
                          ? Icons.pause
                          : Icons.my_library_music_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: (!IAPConnection().isAvailable &&
                          musicModel?.isPremium == true)
                      ? Container(
                          padding: const EdgeInsets.only(
                              left: 6, top: 2, right: 2, bottom: 6),
                          decoration: const BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20))),
                          child: ImageHelper.loadFromAsset(AppAssets.icPremium,
                              width: 10, height: 10),
                        )
                      : const SizedBox())
            ],
          ),
          Text(
            musicModel?.title ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyles.caption.regular
                .setColor(Colors.black)
                .setFontWeight(FontWeight.w500),
          )
        ],
      ),
    );
  }
}
