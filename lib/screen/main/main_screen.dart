import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/common/app_func.dart';
import '../../core/theme/app_colors.dart';
import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);
  final bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => Scaffold(
          drawerEdgeDragWidth: 0,
          backgroundColor: Colors.transparent,
          body: IndexedStack(
            children: controller.menuPages,
            index: controller.navMenuIndex(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.navMenuIndex(),
            items: controller.navMenuItems,
            onTap: (index) {
              controller.onTapBottomBar(index);
            },
            backgroundColor: Colors.red,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.pinkAccent,
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            selectedLabelStyle: TextStyle(color: Colors.pinkAccent),
            showUnselectedLabels: true,
          ))),
    );
  }
}
