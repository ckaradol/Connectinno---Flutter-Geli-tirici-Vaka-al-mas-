import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';
import '../repositories/note_repository.dart';

class LocalNoteService implements NoteRepository {
  final Database _db;

  LocalNoteService(this._db);

  @override
  Future<List<Note>> getNotes({int limit = 10, String? nextToken, String? search}) async {
    String where = '';
    List<dynamic> args = [];

    if (search != null) {
      where = 'WHERE title LIKE ? OR content LIKE ?';
      args.addAll(['%$search%', '%$search%']);
    }

    final result = await _db.rawQuery('SELECT * FROM notes $where ORDER BY created_at DESC', args);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  @override
  Future<Note> createNote(Note note) async {
    await _db.insert('notes', note.toJson());

    return note;
  }

  @override
  Future<Note> updateNote(Note note) async {
    await _db.update('notes', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
    return note;
  }

  @override
  Future<void> deleteNote(String id) async {
    await _db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
