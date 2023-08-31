import 'package:audio_wave/audio_wave.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/ad_manager.dart';
import 'package:flutter_app_vibrator_strong/applovin_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';
import '../../core/assets/app_assets.dart';
import '../../core/common/app_func.dart';
import '../../core/common/imagehelper.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/dimens.dart';
import '../../core/theme/textstyles.dart';
import '../../in_app_manage.dart';
import '../../language/i18n.g.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_scaffold.dart';
import '../../utils/scrolling_text.dart';
import '../../utils/touchable.dart';
import 'package:filling_slider/filling_slider.dart';
import '../../widget/item_music.dart';
import '../../widget/item_vibration.dart';
import 'package:rive/rive.dart';
import 'vibration_controller.dart';
import 'package:applovin_max/applovin_max.dart';

class VibrationScreen extends GetView<VibrationController> {
  VibrationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideBackButton: true,
      appBarHeight: 0,
      hideAppBar: true,
      paddingTop: 0,
      body: ExpandableBottomSheet(
        key: key,
        animationDurationExtend: const Duration(milliseconds: 500),
        animationDurationContract: const Duration(milliseconds: 250),
        animationCurveExpand: Curves.bounceOut,
        animationCurveContract: Curves.ease,
        persistentContentHeight: Dimens.screenHeight * 0.32,
        background: Stack(
          children: [
            Obx(() => ImageHelper.loadFromAsset(
                controller.backgroundColor.value.isEmpty
                    ? AppAssets.imgDry
                    : controller.backgroundColor.value,
                width: Dimens.screenWidth,
                height: Dimens.screenHeight,
                fit: BoxFit.cover)),
            Column(
              children: [
                SizedBox(
                  height: 85.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Obx(() => Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.purple.withOpacity(.15),
                                offset: const Offset(1, 0),
                                blurRadius: 20,
                                spreadRadius: 3)
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.r),
                            child: FillingSlider(
                                initialValue: controller.initValue.value,
                                width: 100,
                                height: 250,
                                onChange: (a, b) {
                                  controller.progress.value = a;
                                  if ((a == 0.5 || a == 0.85) &&
                                      (!IAPConnection().isAvailable)) {
                                    Get.toNamed(Routes.PREMIUM);
                                  }
                                  Vibration.vibrate(
                                      amplitude: (a * 255).toInt(),
                                      repeat: 1,
                                      intensities: [(a * 100).toInt(), 255]);
                                },
                                color: Colors.white,
                                fillColor: Colors.purple,
                                child: SizedBox(
                                  width: 100,
                                  height: 220,
                                  child: Column(
                                    children: [
                                      if (!IAPConnection().isAvailable)
                                        ImageHelper.loadFromAsset(
                                            AppAssets.icPremium,
                                            width: 12.w,
                                            height: 12.w),
                                      Text(I18n().highStr.tr,
                                          style: TextStyles.label2.copyWith(
                                              color:
                                                  controller.progress.value >=
                                                          0.8
                                                      ? Colors.white
                                                      : Colors.black)),
                                      const Spacer(),
                                      if (!IAPConnection().isAvailable)
                                        ImageHelper.loadFromAsset(
                                            AppAssets.icPremium,
                                            width: 12.w,
                                            height: 12.w),
                                      Text(
                                        I18n().mediumStr.tr,
                                        style: TextStyles.label2.copyWith(
                                            color:
                                                controller.progress.value >= 0.5
                                                    ? Colors.white
                                                    : Colors.black),
                                      ),
                                      const Spacer(),
                                      Text(
                                        I18n().lowStr.tr,
                                        style: TextStyles.label2.copyWith(
                                            color: controller.progress.value >=
                                                    0.08
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        )),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  height: 30.h,
                  child: Obx(() => ScrollingText(
                        text: controller.song.value,
                        textStyle: TextStyles.body1,
                      )),
                ),
              ],
            )
          ],
        ),
        persistentHeader: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r)),
          ),
          height: 50.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      I18n().vibrationPatternsStr.tr,
                      style: TextStyles.body3
                          .setTextSize(12.sp)
                          .setColor(Colors.black)
                          .semiBold,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      I18n().subVibrationPatternsStr.tr,
                      style: TextStyles.defaultStyle.setTextSize(10.sp),
                    )
                  ],
                ),
              ),
              Touchable(
                  onTap: () async {
                    Vibration.cancel();
                    bool isReady = (await AppLovinMAX.isInterstitialReady(
                        AdManager.interstitialAdUnitId))!;
                    if (isReady && !IAPConnection().isAvailable) {
                      AppLovinMAX.showInterstitial(AdManager.interstitialAdUnitId);
                    } else {
                      AppLovinMAX.loadInterstitial(AdManager.interstitialAdUnitId);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.lightBlueAccent.withOpacity(0.5),
                        width: 0.5,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    child: Row(
                      children: [
                        Text(
                          I18n().stopVibrationStr.tr,
                          style: TextStyles.defaultStyle.setTextSize(12.sp),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        expandableContent: Container(
          constraints: BoxConstraints(maxHeight: Dimens.screenHeight * 0.32),
          color: Colors.white,
          width: Dimens.screenWidth,
          child: Obx(() => GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (_, index) => ItemVibration(
                  vibrationModel: controller.vibrations[index],
                  controller: controller,
                  index: index,
                ),
                itemCount: controller.vibrations.length,
              )),
        ),
        enableToggle: false,
      ),
    );
  }
}
