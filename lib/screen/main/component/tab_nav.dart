import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main_controller.dart';
import 'tab_nav.dart';
import '../model/screen_model.dart';

class TabNav extends GetView<MainController> {
  final ScreenModel model;

  const TabNav(this.model);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(model.navKey),
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => PageColorList(model: model)),
    );
  }
}

class PageColorList extends StatelessWidget {
  final ScreenModel? model;

  const PageColorList({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model?.screen ?? const SizedBox();
  }
}
