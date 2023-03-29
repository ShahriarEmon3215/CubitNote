import '../db_helper/sqfile_database.dart';
import '../models/note.dart';

class DatabaseRepository {
  SqfliteDatabaseHelper sqfliteDatabaseHelper = new SqfliteDatabaseHelper();

  Future<int> insertNote(Note note) async {
    return await sqfliteDatabaseHelper.insertNote(note);
  }

  Future<List<Note>> getNotes() async {
    return await sqfliteDatabaseHelper.getNotes();
  }

  Future<int> updateNote(Note note) async {
    return await sqfliteDatabaseHelper.updateNote(note);
  }

  Future<int> deleteNote(int id) async {
    return await sqfliteDatabaseHelper.deleteNote(id);
  }

}
