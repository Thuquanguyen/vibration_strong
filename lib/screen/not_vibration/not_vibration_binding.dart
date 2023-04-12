import 'package:get/get.dart';

import 'not_vibration_controller.dart';

class NotVibrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotVibrationController(),fenix: true);
  }
}
