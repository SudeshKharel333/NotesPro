import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notespro/screen/list_notes/list_notes_logic.dart';
import '../../core/helper/input_validator.dart';
import '../../core/services/sqlite_service.dart';
import '../../screen/homescreen/homescreen_view.dart';

class HomescreenLogic extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  late SqliteService _sqliteService;

  @override
  void onInit() {
    super.onInit();
    _sqliteService = SqliteService();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      await _sqliteService.initializeDB();
      print("Database initialization complete.");
    } catch (e) {
      print("Error initializing database: $e");
      // Handle any errors during DB initialization
    }
  }

  bool validateFields() {
    return InputValidators.nameValidation(titleController.text) == null &&
        InputValidators.simpleValidation(contentController.text) == null;
  }

  Future<void> createNote() async {
    try {
      int userId = await _sqliteService.insertNote(
          titleController.text, contentController.text);
      print("Note created with ID: $userId");
      final notelistlogic = Get.find<ListNotesLogic>();
      notelistlogic.getNotesList();
    } catch (e) {
      print("Error creating note: $e");
      // Handle any errors during note creation
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
