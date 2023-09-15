import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/ad_manager.dart';
import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:flutter_app_vibrator_strong/language/i18n.g.dart';
import 'package:flutter_app_vibrator_strong/routes/app_pages.dart';
import 'package:flutter_app_vibrator_strong/screen/music/music_screen.dart';
import 'package:flutter_app_vibrator_strong/screen/vibration/vibration_screen.dart';
import 'package:get/get.dart';
import '../../vibrator_manage.dart';
import '../meditate/meditate_screen.dart';
import '../more/more_screen.dart';
import '../sleep/sleep_screen.dart';
import 'component/tab_nav.dart';
import 'keep_alive_page.dart';
import 'model/screen_model.dart';
import 'package:vibration/vibration.dart';

class MainController extends BaseController{
  final screensData = <ScreenModel>[
    ScreenModel(
        name: I18n().massageStr.tr,
        screen: KeepAlivePage(child:  VibrationScreen()),
        navKey: 1,
        icon: Icons.vibration),
    ScreenModel(
        name: I18n().soundsStr.tr,
        screen: KeepAlivePage(child: const MusicScreen()),
        navKey: 2,
        icon: Icons.queue_music_outlined),
    ScreenModel(
        name: I18n().meditateStr.tr,
        screen: KeepAlivePage(child: const MeditateScreen()),
        navKey: 3,
        icon: Icons.ac_unit),
    ScreenModel(
        name: I18n().sleepStr.tr,
        screen: KeepAlivePage(child: const SleepScreen()),
        navKey: 4,
        icon: Icons.adb_rounded),
    ScreenModel(
        name: I18n().moreStr.tr,
        screen: KeepAlivePage(child: const MoreScreen()),
        navKey: 5,
        icon: Icons.more_horiz),
  ];

  final navMenuIndex = 0.obs;

  ScreenModel get currentScreenModel => screensData[navMenuIndex()];

  // store the pages stack.
  List<Widget>? _pages;

  // get navigators.
  List<Widget> get menuPages =>
      _pages ??= screensData.map((e) => TabNav(e)).toList();

  // widget stuffs.
  List<BottomNavigationBarItem> get navMenuItems => screensData.map((e) {
        return BottomNavigationBarItem(icon: Icon(e.icon), label: e.name);
      }).toList();

  void onTapBottomBar(int index) {
    navMenuIndex.value = index;
  }

  void popToRoot() {
    (currentScreenModel.screen as KeepAlivePage).popToRoot();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    checkVibration();
    super.onInit();
  }



  void checkVibration() async {
    bool hasVibrator = await Vibration.hasVibrator() ?? false;
    print("hasVibrator = ${hasVibrator}");
    VibratorManager().hasVibrator = hasVibrator;
    print("IAPConnection().hasVibrator = ${VibratorManager().hasVibrator}");
  }
}
