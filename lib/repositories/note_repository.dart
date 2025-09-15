import '../models/note_model.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes({String? search,int limit=10,String? nextToken});
  Future<Note> getNoteById(String id);
  Future<Note> createNote(Note note);
  Future<Note> updateNote(Note note);
  Future<void> deleteNote(String id);
}
