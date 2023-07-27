import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_vibrator_strong/screen/vibration/vibration_controller.dart';
import 'package:flutter_app_vibrator_strong/utils/app_utils.dart';
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
import '../utils/touchable.dart';

class ItemMusic extends StatelessWidget {
  ItemMusic({Key? key, this.musicModel,this.controller, this.index})
      : super(key: key);
  MusicModel? musicModel;
  MusicController? controller;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onTap: () {
        if (!IAPConnection().isAvailable && index != 0 && index != 1) {
          AppFunc.showAlertDialogConfirm(context,
              message: 'You need to be active or watch ads to listen to this song. Do you wanna hear?',
              callBack: () {
                goToScreen(PremiumScreen());
              },
              cancelCallback: () {
                controller?.rewardedAd?.show(onUserEarnedReward: (a,b){
                  controller?.changeSelectedMusic(index ?? 0);
                  musicModel?.onTab?.call();
                  AudioPlayerVibration().currentUrl = musicModel?.path ?? AppAssets.musicCover1;
                  AudioPlayerVibration()
                      .playAudio(title: musicModel?.title ?? '');
                });
              });
        } else {
          controller?.changeSelectedMusic(index ?? 0);
          musicModel?.onTab?.call();
          AudioPlayerVibration().currentUrl = musicModel?.path ?? AppAssets.musicCover1;
          AudioPlayerVibration()
              .playAudio(title: musicModel?.title ?? '');
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        color: Colors.purple.withOpacity(0.8),
        elevation: 0.4,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white70, width: 2)),
                padding: EdgeInsets.all(8.w),
                child: Center(
                  child: Icon(
                    (musicModel?.isSelected ?? false)
                        ? Icons.pause
                        : Icons.my_library_music_outlined,
                    size: 20,
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: Text(
                musicModel?.title ?? '',
                style: TextStyles.body3.regular.setColor(Colors.white),
              )),
              if (!IAPConnection().isAvailable && index != 0 && index != 1)
                SizedBox(
                  width: 15.w,
                ),
              if (!IAPConnection().isAvailable && index != 0 && index != 1)
                ImageHelper.loadFromAsset(AppAssets.icPremium,
                    width: 20, height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
