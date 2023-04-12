import 'package:flutter/material.dart';

class ScreenModel {
  final String? name;
  final Widget? screen;
  final int? navKey;
  final IconData? icon;

  ScreenModel({this.screen, this.navKey, this.name,this.icon});
}
