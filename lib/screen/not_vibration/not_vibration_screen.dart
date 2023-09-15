import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/language/i18n.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../vibrator_manage.dart';
import '../../utils/app_scaffold.dart';
import '../../utils/app_utils.dart';
import 'not_vibration_controller.dart';

class NotVibrationScreen extends GetView<NotVibrationController> {
  const NotVibrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        color: Colors.white,
        safeArea: true,
        paddingTop: 0,
        title: I18n().notVibrationStr.tr,
        body: Column(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Text(I18n().contentNotVibrationStr.tr),
                )),
          ],
        ));
  }
}
