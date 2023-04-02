import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class SqfliteDatabaseHelper {
  static final SqfliteDatabaseHelper _instance =
      SqfliteDatabaseHelper.internal();
  SqfliteDatabaseHelper.internal();
  factory SqfliteDatabaseHelper() => _instance;
  static final int version = 1;
  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  Future initDB() async {
    String path = join(await getDatabasesPath(), "cubit_ai_note.db");
    return await openDatabase(path, version: version, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      var dbBatch = db.batch();
      dbBatch.execute(createNotesTable());
      await dbBatch.commit(noResult: true);
    }, onUpgrade: (Database db, currentVersion, newVersion) async {
      final upgradeCalls = {
        2: (Database db, Batch dbBatch) async {
          dbBatch.execute('DROP TABLE IF EXISTS note_table');
          dbBatch.execute(createNotesTable());
        },
      };
      var dbBatch = db.batch();
      upgradeCalls.forEach((vesion, call) async {
        if (version > currentVersion) await call(db, dbBatch);
      });
      await dbBatch.commit(noResult: true);
    });
  }

  /*
       date : 29 March 2023
       developed by SHAHRIAR EMON
       shahriar3215emon@gmail.com
  */

  String createNotesTable() {
    return "CREATE TABLE IF NOT EXISTS note_table ("
        "id INTEGER PRIMARY KEY,"
        "title TEXT,"
        "body TEXT,"
        "creationDate TEXT,"
        "lastModified TEXT); ";
  }

  Future<int> insertNote(Note note) async {
    Database db = await database;
    var result = await db.insert("note_table", note.toJson());
    return result;
  }

  Future<List<Note>> getNotes() async {
    Database db = await database;
    List<Note> notes = <Note>[];
    var noteMapList = await db.query("note_table", orderBy: 'creationDate');

    if (noteMapList.length == 0) return notes;
    for (int i = 0; i < noteMapList.length; i++) {
      notes.add(Note.fromJson(noteMapList[i]));
    }
    return notes;
  }

  Future<int> updateNote(Note note) async {
    Database db = await database;
    var result = await db.update("note_table", note.toJson(),
        where: "id=?", whereArgs: [note.id]);
    print(result);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await database;
    int result =
        await db.delete('note_table', where: "id = ?", whereArgs: [id]);
    return result;
  }

  dbClose() {
    //_database?.close();
  }
}
