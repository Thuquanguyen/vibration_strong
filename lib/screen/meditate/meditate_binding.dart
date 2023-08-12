import 'package:get/get.dart';

import 'meditate_controller.dart';

class MeditateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MeditateController());
  }
}
