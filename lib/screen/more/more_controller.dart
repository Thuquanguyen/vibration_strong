import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../ad_manager.dart';
import '../../admod_handle.dart';
import '../../core/base/base_controller.dart';
import '../../core/common/app_func.dart';
import '../../core/model/vibration_model.dart';
import '../../vibrator_manage.dart';
import '../../language/i18n.g.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_utils.dart';
import '../information/information_screen.dart';
import '../not_vibration/not_vibration_screen.dart';

class MoreController extends BaseController {
  List<VibrationModel> vibrations = [
    VibrationModel(
        iconData: Icons.info_outline,
        title: I18n().informationStr.tr,
        onTap: () {
          Get.toNamed(Routes.INFORMATION);
        }),
    VibrationModel(
        iconData: Icons.warning,
        title: I18n().notVibrationStr.tr,
        onTap: () {
          Get.toNamed(Routes.NOT_VIBRATION);
        }),
    VibrationModel(
        iconData: Icons.feedback_outlined,
        title: I18n().sendFeedbackStr.tr,
        onTap: () async {
          final Email email = Email(
            body: 'Email body',
            subject: 'Vibration strong: Vibrator App',
            recipients: ['support.vibrater@gmail.com'],
            attachmentPaths: ['/path/to/attachment.zip'],
            isHTML: false,
          );
          await FlutterEmailSender.send(email);
        }),
    VibrationModel(
        iconData: Icons.share,
        title: I18n().shareStr.tr,
        onTap: () {
          Share.share(
              "https://play.google.com/store/apps/details?id=com.flutter.flutter_app_vibrator_strong&hl=en&gl=US",
              subject: "Vibration strong: Vibrator App");
        }),
  ];
  RxBool isLoadAds = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

}
