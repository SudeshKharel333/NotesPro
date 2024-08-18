import 'package:get/get.dart';

import 'homescreen_logic.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomescreenLogic());
  }
}
