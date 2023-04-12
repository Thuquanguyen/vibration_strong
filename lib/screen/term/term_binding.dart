import 'package:get/get.dart';

import 'term_controller.dart';

class TermBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermController(),fenix: true);
  }
}
