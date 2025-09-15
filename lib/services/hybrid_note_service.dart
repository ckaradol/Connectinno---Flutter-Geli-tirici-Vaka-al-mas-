import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';
import '../repositories/note_repository.dart';

class HybridNoteService implements NoteRepository {
  final NoteRepository remote;
  final NoteRepository local;

  HybridNoteService({required this.remote, required this.local}) {

    Connectivity().onConnectivityChanged.listen((status) async {
      if (status.first != ConnectivityResult.none) {
        await sync();
      }
    });
  }

  Future<bool> _hasConnection() async {

    final connectivity = await Connectivity().checkConnectivity();
    return connectivity.first != ConnectivityResult.none;
  }

  Future<void> sync() async {
    if (!await _hasConnection()) return;
    User? user= FirebaseAuth.instance.currentUser;

    final localNotes = await local.getNotes();
    final remoteNotes = await remote.getNotes();

    final remoteMap = {for (var n in remoteNotes) n.id: n};
    final localMap = {for (var n in localNotes) n.id: n};

    for (var localNote in localNotes) {
      if ((!remoteMap.containsKey(localNote.id))&&localNote.userId==user?.uid) {
        await remote.createNote(localNote);
      }
    }

    for (var remoteNote in remoteNotes) {
      if ((!localMap.containsKey(remoteNote.id))&&remoteNote.userId==user?.uid) {
        await local.createNote(remoteNote);
      }
    }
  }

  @override
  Future<List<Note>> getNotes({int limit = 10, String? nextToken, String? search}) async {
    if (await _hasConnection()) {
      final notes = await remote.getNotes(limit: limit, nextToken: nextToken, search: search);
      for (var note in notes) {
        await local.updateNote(note);
      }
      return notes;
    } else {
      return local.getNotes(limit: limit, nextToken: nextToken, search: search);
    }
  }


  @override
  Future<Note> createNote(Note note) async {
    if (await _hasConnection()) {
      final newNote = await remote.createNote(note);
      await local.createNote(newNote);
      return newNote;
    } else {
      await local.createNote(note);
      return note;
    }
  }

  @override
  Future<Note> updateNote(Note note) async {
    final updated = note;
    if (await _hasConnection()) {
      final remoteUpdated = await remote.updateNote(updated);
      await local.updateNote(remoteUpdated);
      return remoteUpdated;
    } else {
      await local.updateNote(updated);
      return updated;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    if (await _hasConnection()) {
      await remote.deleteNote(id);
      await local.deleteNote(id);
    } else {
      await local.deleteNote(id);
    }
  }
}
