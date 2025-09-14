import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/services/note_service.dart';

import '../../repositories/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
   NoteRepository repository=NoteService();
  List<Note> _notes = [];

  NoteBloc() : super(NoteInitial()) {
    on<InitRepository>((event, emit) async {
      emit(NoteLoading());
      String? token=await event.user.getIdToken(true);
      repository=NoteService( token: token);
      add(LoadNotes());
    });
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        _notes = await repository.getNotes(search: event.search);
        emit(NoteLoaded(_notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<AddNote>((event, emit) async {
      try {
        final newNote = await repository.createNote(event.note);
        _notes.insert(0, newNote);
        emit(NoteLoaded(List.from(_notes)));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<EditNote>((event, emit) async {
      try {
        final updatedNote = await repository.updateNote(event.note);
        _notes = _notes.map((n) => n.id == event.note.id ? updatedNote : n).toList();
        emit(NoteLoaded(List.from(_notes)));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<RemoveNote>((event, emit) async {
      try {
        await repository.deleteNote(event.id);
        _notes.removeWhere((n) => n.id == event.id);
        emit(NoteLoaded(List.from(_notes)));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
  }
}
