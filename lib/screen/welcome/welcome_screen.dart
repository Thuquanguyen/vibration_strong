import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../core/assets/app_assets.dart';
import '../../core/common/imagehelper.dart';
import '../../core/local_storage/localStorageHelper.dart';
import '../../core/theme/dimens.dart';
import '../../core/theme/textstyles.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_scaffold.dart';
import '../../utils/touchable.dart';
import 'welcome_controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        hideAppBar: true,
        body: Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
              width: Dimens.screenWidth,
              height: Dimens.screenHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                    controller.firstScreen.value
                        ? Colors.red.withOpacity(0.9)
                        : Colors.blueAccent.withOpacity(0.2),
                    controller.firstScreen.value
                        ? Colors.red.withOpacity(0.2)
                        : Colors.purple,
                  ],
                      stops: const [
                    0.0,
                    1.0
                  ])),
              child: controller.firstScreen.value ? _step1() : _step2(),
            )));
  }
}

extension on WelcomeScreen {
  _step1() {
    return Column(
      children: [
        const Spacer(),
        ImageHelper.loadFromAsset(AppAssets.icWelcome,
            tintColor: Colors.white, width: 100.w, height: 100.w),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Welcome to',
          textAlign: TextAlign.center,
          style: TextStyles.title1
              .setColor(Colors.white)
              .setHeight(1.2)
              .setTextSize(28.sp)
              .bold,
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          'Vibration!',
          textAlign: TextAlign.center,
          style: TextStyles.title1
              .setColor(Colors.white)
              .setHeight(1.2)
              .setTextSize(25.sp)
              .bold,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'The best and most relaxing\nmassager',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle
              .setColor(Colors.white.withOpacity(0.7))
              .setHeight(1.2)
              .setTextSize(19.sp)
              .regular,
        ),
        const Spacer(),
        Touchable(
            onTap: () {
              controller.firstScreen.value = false;
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30.r)),
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: Text(
                  'Continue',
                  style: TextStyles.defaultStyle
                      .setTextSize(20.sp)
                      .setColor(Colors.white),
                ),
              ),
            ))
      ],
    );
  }

  _step2() {
    return Column(
      children: [
        const Spacer(),
        Text(
          'Try different patterns',
          textAlign: TextAlign.center,
          style: TextStyles.title1
              .setColor(Colors.white)
              .setHeight(1.2)
              .setTextSize(28.sp)
              .bold,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Just perfect vibrator app massager with customizable strong vibration.',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle
              .setColor(Colors.white.withOpacity(0.8))
              .setTextSize(16.sp)
              .regular,
        ),
        const Spacer(),
        Touchable(
            onTap: () async {
              SharePreferencesHelper.setBool(KEY_WELCOME, true);
              Get.toNamed(Routes.PREMIUM);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30.r)),
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: Text(
                  'Continue',
                  style: TextStyles.defaultStyle
                      .setTextSize(20.sp)
                      .setColor(Colors.white),
                ),
              ),
            ))
      ],
    );
  }
}
