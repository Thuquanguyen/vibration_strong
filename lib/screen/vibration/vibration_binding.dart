import 'package:get/get.dart';

import 'vibration_controller.dart';

class VibrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VibrationController(),fenix: true);
  }
}
