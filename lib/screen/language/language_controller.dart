import 'package:flutter_app_vibrator_strong/applovin_manager.dart';
import 'package:flutter_app_vibrator_strong/core/base/base_controller.dart';
import 'package:get/get.dart';

import '../../core/model/language_model.dart';
import 'package:applovin_max/applovin_max.dart';

class LanguageController extends BaseController {
  RxList<LanguageModel> listLanguages = <LanguageModel>[
    LanguageModel(name: "English", subName: "English", isChecked: true),
    LanguageModel(name: "Russian", subName: ""),
    LanguageModel(name: "Brazil", subName: ""),
    LanguageModel(name: "German", subName: ""),
    LanguageModel(name: "Portuguese", subName: ""),
    LanguageModel(name: "Spanish", subName: ""),
    LanguageModel(name: "French", subName: ""),
    LanguageModel(name: "Hindi", subName: ""),
    LanguageModel(name: "Korean", subName: ""),
    LanguageModel(name: "Japanese", subName: ""),
    LanguageModel(name: "Italia", subName: ""),
    LanguageModel(name: "Marathi", subName: ""),
    LanguageModel(name: "Urdu", subName: ""),
    LanguageModel(name: "Thailand", subName: ""),
    LanguageModel(name: "Indonesian", subName: ""),
  ].obs;
  Rx<MaxNativeAdViewController> nativeAdViewController = MaxNativeAdViewController().obs;
  static double kMediaViewAspectRatio = 16 / 9;

  RxString statusText = "".obs;

  RxDouble mediaViewAspectRatio = kMediaViewAspectRatio.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    nativeAdViewController.value.loadAd();
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
