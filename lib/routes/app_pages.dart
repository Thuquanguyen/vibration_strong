import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/screen/language/language_binding.dart';
import 'package:flutter_app_vibrator_strong/screen/language/language_screen.dart';
import 'package:flutter_app_vibrator_strong/screen/main/main_binding.dart';
import 'package:flutter_app_vibrator_strong/screen/main/main_screen.dart';
import 'package:flutter_app_vibrator_strong/screen/more/more_binding.dart';
import 'package:flutter_app_vibrator_strong/screen/more/more_screen.dart';
import 'package:flutter_app_vibrator_strong/screen/music/music_binding.dart';
import 'package:flutter_app_vibrator_strong/screen/music/music_screen.dart';
import 'package:flutter_app_vibrator_strong/screen/vibration/vibration_screen.dart';
import 'package:get/get.dart';

import '../screen/information/information_binding.dart';
import '../screen/information/information_screen.dart';
import '../screen/meditate/meditate_binding.dart';
import '../screen/meditate/meditate_screen.dart';
import '../screen/not_vibration/not_vibration_binding.dart';
import '../screen/not_vibration/not_vibration_screen.dart';
import '../screen/premium/premium_binding.dart';
import '../screen/premium/premium_screen.dart';
import '../screen/privacy/privacy_binding.dart';
import '../screen/privacy/privacy_screen.dart';
import '../screen/sleep/sleep_binding.dart';
import '../screen/sleep/sleep_screen.dart';
import '../screen/splash/splash_binding.dart';
import '../screen/splash/splash_screen.dart';
import '../screen/term/term_binding.dart';
import '../screen/term/term_screen.dart';
import '../screen/vibration/vibration_binding.dart';
import '../screen/welcome/welcome_binding.dart';
import '../screen/welcome/welcome_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.MEDITATE,
      page: () => MeditateScreen(),
      binding: MeditateBinding(),
    ),
    GetPage(
      name: _Paths.SLEEP,
      page: () => SleepScreen(),
      binding: SleepBinding(),
    ),
    GetPage(
      name: _Paths.VIBRATION,
      page: () =>  VibrationScreen(),
      binding: VibrationBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.MUSIC,
      page: () => MusicScreen(),
      binding: MusicBinding(),
    ),
    GetPage(
      name: _Paths.INFORMATION,
      page: () => InformationScreen(),
      binding: InformationBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeScreen(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.PREMIUM,
      page: () => const PremiumScreen(),
      binding: PremiumBinding(),
    ),
    GetPage(
      name: _Paths.TERM,
      page: () => const TermScreen(),
      binding: TermBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY,
      page: () => const PrivacyScreen(),
      binding: PrivacyBinding(),
    ),
    GetPage(
      name: _Paths.NOT_VIBRATION,
      page: () => const NotVibrationScreen(),
      binding: NotVibrationBinding(),
    ),
    GetPage(
      name: _Paths.MORE,
      page: () => const MoreScreen(),
      binding: MoreBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageScreen(),
      binding: LanguageBinding(),
    ),
  ];
}
