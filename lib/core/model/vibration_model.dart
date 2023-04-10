import 'package:flutter/cupertino.dart';

class VibrationModel {
  String? icon;
  IconData? iconData;
  String? title;
  bool? isPremium;
  Function? onTap;
  bool? isSelected;

  VibrationModel({this.icon, this.title, this.onTap,this.iconData,this.isPremium = true,this.isSelected = false});
}
