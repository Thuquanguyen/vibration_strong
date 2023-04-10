import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'data_holder.dart';


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
