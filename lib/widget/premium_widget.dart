import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/assets/app_assets.dart';
import '../core/common/imagehelper.dart';
import '../core/theme/textstyles.dart';
import '../language/i18n.g.dart';
import '../routes/app_pages.dart';
import '../screen/not_vibration/not_vibration_screen.dart';
import '../screen/premium/premium_screen.dart';
import '../utils/app_utils.dart';
import '../utils/touchable.dart';

class PremiumWidget extends StatelessWidget {
  const PremiumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onTap: () {
        Get.toNamed(Routes.PREMIUM);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 1),
                  blurRadius: 4,
                  spreadRadius: 0)
            ]),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10.w),
              child: Center(
                child: ImageHelper.loadFromAsset(AppAssets.icPremium,
                    width: 22.w, height: 22.w),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    I18n().unlockPremiumStr.tr,
                    style: TextStyles.title1
                        .setColor(Colors.white),
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                    I18n().subUnlockPremiumStr.tr,
                    style: TextStyles.defaultStyle.setTextSize(13.sp).setColor(Colors.white),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.navigate_next,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
