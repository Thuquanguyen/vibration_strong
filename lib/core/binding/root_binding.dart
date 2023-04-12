import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    List<Bindings?> _listBinding =
        AppPages.routes.map((e) => e.binding).toList();
    for (int i = 0; i < _listBinding.length; i++) {
      if (_listBinding[i] != null) {
        _listBinding[i]!.dependencies();
      }
    }
  }
}
