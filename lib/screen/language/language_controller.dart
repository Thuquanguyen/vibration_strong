import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_app_vibrator_strong/ad_manager.dart';
import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:get/get.dart';

import '../../admod_handle.dart';
import '../../core/model/data_model.dart';
import '../../core/model/language_model.dart';

class LanguageController extends BaseController {
  RxList<LanguageModel> listLanguages = <LanguageModel>[
    LanguageModel(
        key: "en", name: "English", subName: "English", isChecked: true),
    LanguageModel(key: "ru", name: "Russian", subName: "Русский"),
    LanguageModel(key: "de", name: "German", subName: "Deutsch"),
    LanguageModel(key: "pt", name: "Portuguese", subName: "Português"),
    LanguageModel(key: "es", name: "Spanish", subName: "Española"),
    LanguageModel(key: "fr", name: "French", subName: "Français"),
    LanguageModel(key: "hi", name: "Hindi", subName: "हिंदी"),
    LanguageModel(key: "ko", name: "Korean", subName: "한국인"),
    LanguageModel(key: "ja", name: "Japanese", subName: "日本語"),
    LanguageModel(key: "mr", name: "Marathi", subName: "मराठी"),
    LanguageModel(key: "th", name: "Thailand", subName: "ประเทศไทย"),
    LanguageModel(key: "id", name: "Indonesian", subName: "bahasa Indonesia"),
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void changeLanguage(int index) {
    if (listLanguages[index].isChecked == true) {
      listLanguages[index].isChecked = false;
    } else {
      for (int i = 0; i < listLanguages.length; i++) {
        listLanguages[i].isChecked = false;
      }
      listLanguages[index].isChecked = true;
    }
    listLanguages.refresh();
  }
}
