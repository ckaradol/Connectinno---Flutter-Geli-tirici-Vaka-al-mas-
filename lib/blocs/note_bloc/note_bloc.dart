import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/services/local_note_service.dart';
import 'package:noteapp/services/note_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../repositories/note_repository.dart';
import '../../services/hybrid_note_service.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteRepository repository = NoteService();
  List<Note> _notes = [];
  Note? _lastRemovedNote;
  bool isMore=true;
  NoteBloc() : super(NoteInitial()) {
    on<InitRepository>((event, emit) async {
      emit(NoteLoading());
      String? token;
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity.first != ConnectivityResult.none) {
        try {
          token = await event.user.getIdToken(true);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }

      final db = await openDatabase(
        join(await getDatabasesPath(), 'notes.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE notes(
              id TEXT,
              title TEXT,
              content TEXT,
              user_id TEXT,
              created_at TEXT
            )
          ''');
        },
      );
      repository = HybridNoteService(
        remote: NoteService(token: token),
        local: LocalNoteService(db),
      );

      add(LoadNotes());
    });
    on<LoadNotes>((event, emit) async {
      if(!event.isMore) {
       _notes.clear();
        emit(NoteLoading());
      }
      emit(NoteLoaded(_notes,isMore: isMore,isLoading: true));

      try {
        List<Note> notes = await repository.getNotes(search: event.search, nextToken: event.nextToken);
        if(notes.isEmpty){
          isMore=false;
        }
        for (var data in notes) {
          _notes.remove(data);
          _notes.add(data);
        }
        emit(NoteLoaded(_notes,isMore: isMore,));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<AddNote>((event, emit) async {
      try {
        final newNote = await repository.createNote(event.note);
        _notes.insert(0, newNote);
        emit(NoteLoaded(List.from(_notes),isMore: isMore));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<EditNote>((event, emit) async {
      try {
        final updatedNote = await repository.updateNote(event.note);
        _notes = _notes.map((n) => n.id == event.note.id ? updatedNote : n).toList();
        emit(NoteLoaded(List.from(_notes),isMore: isMore));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<RemoveNote>((event, emit) async {
      try {
        final removedNote = _notes.firstWhere((n) => n.id == event.id);

        _notes.removeWhere((n) => n.id == event.id);
        emit(NoteLoaded(List.from(_notes),isMore: isMore));

        Future.delayed(const Duration(seconds: 30), () async {
          final stillRemoved = !_notes.any((n) => n.id == removedNote.id);
          if (stillRemoved) {
            await repository.deleteNote(event.id);
          }
        });

        _lastRemovedNote = removedNote;
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<UndoRemoveNote>((event, emit) {
      if (_lastRemovedNote != null) {
        _notes.add(_lastRemovedNote!);
        emit(NoteLoaded(List.from(_notes),isMore: isMore));
        _lastRemovedNote = null;
      }
    });
  }
}
