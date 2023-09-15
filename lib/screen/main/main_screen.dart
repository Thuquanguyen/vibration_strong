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
      child: Obx(
        () => Scaffold(
          drawerEdgeDragWidth: 0,
          backgroundColor: (controller.navMenuIndex.value == 1 ||
                  controller.navMenuIndex.value == 2 ||
                  controller.navMenuIndex.value == 3)
              ? Colors.black
              : Colors.white,
          body: IndexedStack(
            children: controller.menuPages,
            index: controller.navMenuIndex(),
          ),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                // boxShadow: const [
                //   BoxShadow(
                //       color: Colors.black38, spreadRadius: 0, blurRadius: 3),
                // ],
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: BottomNavigationBar(
                    currentIndex: controller.navMenuIndex(),
                    items: controller.navMenuItems,
                    onTap: (index) {
                      controller.onTapBottomBar(index);
                    },
                    backgroundColor: Colors.transparent,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white70,
                    unselectedLabelStyle: const TextStyle(color: Colors.grey),
                    selectedLabelStyle: const TextStyle(color: Colors.grey),
                    showUnselectedLabels: true,
                  ))),
        ),
      ),
    );
  }
}
