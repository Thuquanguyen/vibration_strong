import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:flutter/services.dart';

import '../core/common/data_holder.dart';
import '../screen/main/main_controller.dart';


Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
  final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
  final codec = await ui.instantiateImageCodec(
    assetImageByteData.buffer.asUint8List(),
    targetHeight: height,
    targetWidth: width,
  );
  final image = (await codec.getNextFrame()).image;

  return image;
}

bool checkFormat(String regex, String checkedString) {
  return RegExp(regex).hasMatch(checkedString);
}

String convertTimeStringFromDatetime(DateTime date,
    {String format = 'dd/MM/yyyy'}) {
  return DateFormat(format).format(date);
}

String formatDateToBE(DateTime dateTime){
  return DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'').format(dateTime.subtract(const Duration(hours: 9)));
}

Future<dynamic> goToScreen(Widget screen,
    {dynamic arguments, bool preventDuplicates = true}) async {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  if (arguments != null) {
    DataHolder().args = arguments;
  }
  return Get.to(() => screen,
      id: id, arguments: arguments, preventDuplicates: preventDuplicates);
}

Future<dynamic> replaceScreen(Widget screen,
    {dynamic arguments, bool preventDuplicates = true}) async {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  if (arguments != null) {
    DataHolder().args = arguments;
  }
  return Get.off(() => screen,
      id: id ?? 1, arguments: arguments, preventDuplicates: preventDuplicates);
}

void popScreen({dynamic result}) {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  Get.back(id: id ?? 1, result: result);
}

void popUntilScreen(String routeName) {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  Get.offNamedUntil(routeName, (Route<dynamic> route) => false, id: id ?? 1);
}

DateTime getStartDayOfWeek(DateTime date) {
  DateTime tmp = date.subtract(
    Duration(days: date.weekday - 1),
  );
  return DateTime(tmp.year, tmp.month, tmp.day);
}

DateTime getEndDayOfWeek(DateTime date) {
  DateTime tmp = date.add(
    Duration(days: DateTime.daysPerWeek - date.weekday),
  );
  return DateTime(tmp.year, tmp.month, tmp.day);
}
