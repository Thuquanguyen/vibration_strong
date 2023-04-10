import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'textstyles.dart';

final decorTextField = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.customColor15, width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(4)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.customColor15, width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(4)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.neutralColor1, width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(4)),
  ),
  // errorMaxLines: null,
  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
  hintStyle: TextStyles.title3.copyWith(color: AppColors.neutralColor5),
  errorStyle: TextStyles.title3.copyWith(color: Colors.red),
  counterText: '',
  fillColor: Colors.white,
  filled: true,
);

final boxShadow = [
  BoxShadow(
    color: AppColors.customColor31,
    spreadRadius: 0,
    blurRadius: 4,
    offset: const Offset(0, 4),
  ),
];

final boxShadowImageCover = [
  BoxShadow(
    color: AppColors.customColor31.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 15,
    offset: const Offset(0, 6),
  ),
];
