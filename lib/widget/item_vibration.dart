import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/ad_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_app_vibrator_strong/utils/app_loading.dart';
import 'package:vibration/vibration.dart';

import '../admod_handle.dart';
import '../core/assets/app_assets.dart';
import '../core/common/app_func.dart';
import '../core/common/imagehelper.dart';
import '../core/model/vibration_model.dart';
import '../core/theme/textstyles.dart';
import '../in_app_manage.dart';
import '../vibrator_manage.dart';
import '../language/i18n.g.dart';
import '../routes/app_pages.dart';
import '../screen/vibration/vibration_controller.dart';
import '../utils/app_utils.dart';
import '../utils/touchable.dart';

class ItemVibration extends StatelessWidget {
  ItemVibration({Key? key, this.vibrationModel, this.controller, this.index})
      : super(key: key);
  VibrationModel? vibrationModel;
  VibrationController? controller;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onTap: () async {
        if(AdmodHandle().ads.isLimit == false && AdmodHandle().isShowInter && !IAPConnection().isAvailable){
          AdmodHandle().loadAdInter();
          if ((index ?? 0) % 2 == 0 &&
              AdmodHandle().interstitialAd != null &&
              index != controller?.indexOld.value) {
            // show ads
            showLoadingAds();
            AppFunc.setTimeout(() {
              hideLoadingAds();
              AdmodHandle().interstitialAd?.show();
            }, 2000);
          }
        }
        controller?.changeSelected(index ?? 0);
        Vibration.cancel();
        vibrationModel?.onTap?.call();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              width: 50.w,
              height: 50.w,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: vibrationModel?.isSelected == true
                          ? Colors.pinkAccent
                          : Colors.cyanAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.lightBlueAccent.withOpacity(0.5),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: ImageHelper.loadFromAsset(
                          vibrationModel?.icon ?? AppAssets.icPremium,
                          tintColor: vibrationModel?.isSelected == true
                              ? Colors.white
                              : Colors.lightBlueAccent,
                          width: 18.w,
                          height: 18.w),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              vibrationModel?.title ?? I18n().sunnyStr.tr,
              style: TextStyles.defaultStyle.setTextSize(10.sp),
            )
          ],
        ),
      ),
    );
  }
}
