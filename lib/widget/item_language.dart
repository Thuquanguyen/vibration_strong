import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/core/app_translations.dart';
import 'package:flutter_app_vibrator_strong/core/model/language_model.dart';
import 'package:flutter_app_vibrator_strong/screen/language/language_controller.dart';
import 'package:flutter_app_vibrator_strong/utils/touchable.dart';

import '../core/theme/textstyles.dart';

class ItemLanguage extends StatelessWidget {
  const ItemLanguage({this.languageModel, this.controller, this.index});

  final LanguageModel? languageModel;
  final LanguageController? controller;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Touchable(
        onTap: () {
          controller?.changeLanguage(index ?? 0);
          AppTranslations.updateLocale(langCode: languageModel?.key ?? 'en');
        },
        child: Container(
          decoration: BoxDecoration(
              color: languageModel?.isChecked == true
                  ? Colors.pinkAccent
                  : Colors.transparent),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                languageModel?.name ?? '',
                style: TextStyles.body1.setColor(Colors.white),
              )),
              Text(
                languageModel?.name ?? '',
                style: TextStyles.body1.setColor(Colors.white),
              )
            ],
          ),
        ));
  }
}
