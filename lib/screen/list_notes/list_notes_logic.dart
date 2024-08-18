import 'package:get/get.dart';
import '../../core/services/sqlite_service.dart';
import '../../models/db_models/users_module.dart';

class ListNotesLogic extends GetxController {
  late SqliteService _sqliteService;
  List<Notes> notes = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    _sqliteService = SqliteService();
    initializeDatabase();
  }

  void initializeDatabase() async {
    try {
      await _sqliteService.initializeDB();
      print("Database initialized");
      getNotesList();
    } catch (e) {
      print("Error initializing database: $e");
      isLoading = false;
      update();
    }
  }

  void getNotesList() async {
    try {
      notes = await _sqliteService.getNotesList();
      if (notes.isEmpty) {
        print("No notes found");
      } else {
        print("First note title: ${notes[0].title}");
      }
    } catch (e) {
      print("Error fetching notes: $e");
    } finally {
      isLoading = false;
      update(); // Update UI
    }
  }

  void deleteNote(Notes note) async {
    int userId = await _sqliteService.deleteNote(note);
    getNotesList();
    update();
  }
}
