import 'package:get/get.dart';

import 'list_notes_logic.dart';

class ListUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListNotesLogic());
  }
}
