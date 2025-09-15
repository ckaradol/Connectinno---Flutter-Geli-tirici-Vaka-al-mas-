import 'package:sqflite/sqflite.dart';
import '../models/note_model.dart';
import '../repositories/note_repository.dart';
import 'package:path/path.dart';
class LocalNoteService implements NoteRepository {
   final Database _db;

  LocalNoteService( this._db);



  @override
  Future<List<Note>> getNotes({int limit = 10, String? nextToken, String? search}) async {
    String where = '';
    List<dynamic> args = [];

    if (search != null) {
      where = 'WHERE title LIKE ? OR content LIKE ?';
      args.addAll(['%$search%', '%$search%']);
    }

    String limitOffset = 'LIMIT ?';
    args.add(limit);

    if (nextToken != null) {
      where += where.isEmpty ? 'WHERE createdAt > ?' : ' AND createdAt > ?';
      args.add(nextToken);
    }

    final result = await _db.rawQuery(
      'SELECT * FROM notes $where ORDER BY createdAt DESC $limitOffset',
      args,
    );
    return result.map((json) => Note.fromJson(json)).toList();
  }

  @override
  Future<Note> getNoteById(String id) async {
    final result = await _db.query('notes', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) throw Exception('Note not found');
    return Note.fromJson(result.first);
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
