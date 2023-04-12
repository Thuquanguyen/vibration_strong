import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../core/assets/app_assets.dart';
import '../core/common/imagehelper.dart';
import '../core/model/vibration_model.dart';
import '../core/theme/textstyles.dart';
import '../in_app_manage.dart';
import '../routes/app_pages.dart';
import '../screen/premium/premium_screen.dart';
import '../screen/vibration/vibration_controller.dart';
import '../utils/app_utils.dart';
import '../utils/touchable.dart';

class ItemVibration extends StatelessWidget {
  ItemVibration({Key? key, this.vibrationModel,this.controller, this.index})
      : super(key: key);
  VibrationModel? vibrationModel;
  VibrationController? controller;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onTap: () {
        if (!IAPConnection().isAvailable &&  index != 0 && index != 1) {
          Vibration.cancel();
          goToScreen(PremiumScreen());
        } else {
          controller?.changeSelected(index ?? 0);
          Vibration.cancel();
          vibrationModel?.onTap?.call();
        }
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
                  if (!IAPConnection().isAvailable && index != 0 && index != 1)
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomLeft: Radius.circular(6.r))),
                        child: Center(
                          child: ImageHelper.loadFromAsset(AppAssets.icPremium,
                              width: 10.w, height: 10.w),
                        ),
                      ),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              vibrationModel?.title ?? 'Sunny',
              style: TextStyles.defaultStyle.setTextSize(10.sp),
            )
          ],
        ),
      ),
    );
  }
}
