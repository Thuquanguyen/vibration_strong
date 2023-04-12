import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/screen/information/information_screen.dart';
import 'package:flutter_app_vibrator_strong/screen/not_vibration/not_vibration_screen.dart';
import 'package:flutter_app_vibrator_strong/utils/app_utils.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/base/base_controller.dart';
import '../../core/model/vibration_model.dart';
import '../../in_app_manage.dart';
import '../../routes/app_pages.dart';

class MoreController extends BaseController {
  List<VibrationModel> vibrations = [
    VibrationModel(
        iconData: Icons.info_outline,
        title: 'Information',
        onTap: () {
          goToScreen(InformationScreen());
        }),
    VibrationModel(
        iconData: Icons.warning,
        title: 'Not Vibrating?',
        onTap: () {
          goToScreen(NotVibrationScreen());
        }),
    VibrationModel(
        iconData: Icons.feedback_outlined,
        title: 'Send feedback',
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
        iconData: Icons.restore,
        title: 'Restore Purchase',
        onTap: () {
          IAPConnection.instance.restorePurchases();
        }),
    VibrationModel(
        iconData: Icons.share,
        title: 'Share',
        onTap: () {
          Share.share(
              "https://play.google.com/store/apps/details?id=com.flutter.flutter_app_vibrator_strong&hl=en&gl=US",
              subject: "Vibration strong: Vibrator App");
        }),
  ];
}
