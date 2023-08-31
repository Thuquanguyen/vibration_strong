import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/core/local_storage/localStorageHelper.dart';
import 'package:flutter_app_vibrator_strong/language/id_ID.dart';
import 'package:flutter_app_vibrator_strong/language/ja_JP.dart';
import 'package:flutter_app_vibrator_strong/language/ko_KR.dart';
import 'package:flutter_app_vibrator_strong/language/mr_IN.dart';
import 'package:flutter_app_vibrator_strong/language/ru_RU.dart';
import 'package:flutter_app_vibrator_strong/language/th_TH.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../language/de_AT.dart';
import '../language/en_US.dart';
import '../language/es_ES.dart';
import '../language/fr_FR.dart';
import '../language/hi_IN.dart';
import '../language/pt_PT.dart';
import '../language/vi_VN.dart';

class AppTranslations extends Translations {
  // Default locale
  static final locale = Locale('en');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('en');

  static String localeStr = 'en';

  static void init() async{
    localeStr = await SharePreferencesHelper.getString("LANGUAGE") ?? localeStr;
    print("localeStr ===  = ${localeStr}");
    Get.updateLocale(Locale(localeStr));
    Get.rootController.reactive;
  }

  static void updateLocale({required String langCode}) {
    Get.updateLocale(Locale(langCode));
    SharePreferencesHelper.setString("LANGUAGE", langCode);
    Get.rootController.reactive;
  }

  void addNewTranslate(Map<String, Map<String, String>> data) {
    Get.addTranslations(data);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'vi': vi_VN,
        'en': en_US,
        'ru': ru_RU,
        'de': de_AT,
        'es': es_ES,
        'fr': fr_FR,
        'hi': hi_IN,
        'ko': ko_KR,
        'ja': ja_JP,
        'mr': mr_IN,
        'es': es_ES,
        'th': th_TH,
        'id': id_ID,
        'pt': pt_PT,
        'ja': ja_JP,
      };
}
