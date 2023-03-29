import 'package:flutter/cupertino.dart';

import '../../../db_helper/sqfile_database.dart';
import '../../../models/note.dart';

class NoteController extends ChangeNotifier {
  static final SqfliteDatabaseHelper _database = SqfliteDatabaseHelper();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  List<Note> notes = [];
  Future<int> insertNote(Note note) async {
    int? result = await _database.insertNote(note);
    if (result > 0) {
      notes.add(note);
      notifyListeners();
    }
    return result;
  }

  Future<void> getAllNotes() async {
    notes = await _database.getNotes();
    notifyListeners();
  }

  Future<int> updateNote(Note note, int index) async {
    int? result = await _database.updateNote(note);
    if (result > 0) {
      notes.insert(index, note);
      notifyListeners();
    }
    return result;
  }

  Future<int> deleteNote(int id, int index) async {
    int? result = await _database.deleteNote(id);
    if (result > 0) {
      notes.removeAt(index);
      notifyListeners();
    }
    return result;
  }
}
