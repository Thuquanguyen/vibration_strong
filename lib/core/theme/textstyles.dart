import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

double textSize32 = 32.sp;
double textSize22 = 22.sp;
double textSize18 = 18.sp;
double textSize16 = 16.sp;
double textSize15 = 15.sp;
double textSize14 = 14.sp;
double textSize12 = 12.sp;
double textSize10 = 10.sp;

extension ExtendedTextStyle on TextStyle {
  TextStyle get semiBold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.normal);
  }

  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setHeight(double height) {
    return copyWith(height: height);
  }

  TextStyle setFontWeight(FontWeight fontWeight) {
    return copyWith(fontWeight: fontWeight);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size);
  }
}

class TextStyles {
  static const double _height = 1.2;

  static final TextStyle defaultStyle = TextStyle(
          fontSize: textSize14,
          height: _height,
          fontFamily: GoogleFonts.aleo().fontFamily,
          color: AppColors.neutralColor2)
      .regular;

  static TextStyle title1 =
      defaultStyle.copyWith(fontSize: textSize22, height: 1.8).semiBold;
  static TextStyle title2 =
      defaultStyle.copyWith(fontSize: textSize18, height: 1.8).semiBold;
  static TextStyle title3 =
      defaultStyle.copyWith(fontSize: textSize16, height: 1.8).semiBold;

  static TextStyle headline1 =
      defaultStyle.copyWith(fontSize: textSize16, height: 2.0).bold;
  static TextStyle headline2 =
      defaultStyle.copyWith(fontSize: textSize14, height: 1.8).semiBold;

  static TextStyle body1 =
      defaultStyle.copyWith(fontSize: textSize15, height: 1.6).medium;
  static TextStyle body2 = defaultStyle.copyWith(fontSize: textSize15).regular;
  static TextStyle body3 = defaultStyle.copyWith(fontSize: textSize14).regular;

  static TextStyle label1 =
      defaultStyle.copyWith(fontSize: textSize12, height: 1.8).semiBold;
  static TextStyle label2 =
      defaultStyle.copyWith(fontSize: textSize12, height: 1.6).medium;
  static TextStyle link =
      defaultStyle.copyWith(fontSize: textSize14, height: 1.8).semiBold;
  static TextStyle caption =
      defaultStyle.copyWith(fontSize: textSize12, height: 1.8).semiBold;
}
// How to use?
// Text('test text', style: TextStyles.normalText.semibold.whiteColor);
// Text('test text', style: TextStyles.itemText.whiteColor.bold);
