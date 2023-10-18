import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/screen/vibration/vibration_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import '../admod_handle.dart';
import '../core/assets/app_assets.dart';
import '../core/common/app_func.dart';
import '../core/common/imagehelper.dart';
import '../core/model/vibration_model.dart';
import '../core/theme/textstyles.dart';
import '../in_app_manage.dart';
import '../utils/app_loading.dart';
import '../vibrator_manage.dart';
import '../language/i18n.g.dart';
import '../routes/app_pages.dart';
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
        if (vibrationModel?.isPremium == true) {
          Get.toNamed(Routes.PREMIUM);
          return;
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
                  if(vibrationModel?.isPremium == true)
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.only(left: 5,top: 3,right: 3,bottom: 3),
                        margin: EdgeInsets.only(top: 1,right: 1),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                        ),
                        child: ImageHelper.loadFromAsset(AppAssets.icPremium,
                            width: 10, height: 10),
                      ),
                      top: 0,
                      right: 0,
                    )
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
