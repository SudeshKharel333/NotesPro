import 'package:notespro/models/db_models/users_module.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path =
        await getDatabasesPath(); //Get the path where the database will be stored using getDatabasesPath().

    return openDatabase(
      join(
          path,
          'ecomm'
          'ecomm.db'), //Open or create a database named ecomm.db at the specified path.
      onCreate: (database, version) async {
        //onCreate: If the database is being created for the first time, this function runs and creates a table named Notes with columns for id, title, content, and contact.
        await database.execute(
          "CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,content TEXT NOT NULL,contact TEXT)",
        );
        // await database.execute(
        //   "CREATE TABLE TimeLine(id INTEGER PRIMARY KEY AUTOINCREMENT,project_id INTEGER NOT NULL,start_time TEXT ,end_time TEXT ,remarks TEXT ,created_at TEXT NOT NULL,updated_at TEXT NOT NULL)",
        // );
      },
      onUpgrade: (database, oldVersion,
          newVersion) async {}, //This would handle database upgrades (not used here).
      version: 1, // The initial version of the database.
    );
  }

  insertNote(
      String title, String content) //Takes title, content as input parameters.
  async {
    int result = 0;
    final Database db =
        await initializeDB(); //Initialize the database by calling initializeDB().
    try {
      final id = await db.insert(
          'Notes',
          {
            //Uses db.insert to add a new row to the Notes table with the provided values.
            'title': title,
            'content': content,
          },
          conflictAlgorithm: ConflictAlgorithm
              .replace); // If a conflict occurs (e.g., duplicate id), it replaces the existing row
      return id; //Returns the ID of the inserted row if successful, or 0 if there's an error.
    } catch (e) {
      return result;
    }
  }

  Future<List<Notes>> getNotesList() async {
    final Database db =
        await initializeDB(); //The function starts by initializing the database connection with await initializeDB();. This means it prepares the database so that it can perform queries on it.
    try {
      final queryResult = await db.query(
          'Notes'); //The function then runs a query on the 'Users' table in the database by calling db.query('Users');. This query fetches all the records (or rows) in the 'Users' table.
      return queryResult
          .map((v) => Notes.fromJson(v))
          .toList(); //The results from the query are stored in queryResult, which is a list of maps (key-value pairs) where each map represents a row from the database.The function converts each map into a Users object using the Users.fromJson(v) method. This is done for each item in queryResult.
      // return id;
    } catch (e) {
      return []; //After converting all the records, the function returns the list of Users objects.
    }
  } //This function, getUsersList(), is written in Dart and is designed to fetch a list of users from a local database in a Flutter application.

// await db.query('TimeLine', where: "end_time is ?", whereArgs: [null]);
// await db.query('Projects', orderBy: "updated_at DESC",where: "complete_status=0");
// await db.rawQuery(
// "SELECT * FROM Projects WHERE project_name LIKE '${args}%' and complete_status=0;");
  deleteNote(Notes note) async {
    final Database db = await initializeDB();
    try {
      final id =
          await db.delete('Notes', where: "id = ?", whereArgs: [note.id]);
      print("delete success");
      return id;
    } catch (e) {
      print("delete failed : $e");
      return [];
    }
  }
}
