import 'package:get/get.dart';

import 'music_controller.dart';

class MusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MusicController(),fenix: true);
  }
}
