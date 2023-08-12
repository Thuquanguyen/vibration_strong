import 'package:get/get.dart';

import 'sleep_controller.dart';

class SleepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SleepController());
  }
}
