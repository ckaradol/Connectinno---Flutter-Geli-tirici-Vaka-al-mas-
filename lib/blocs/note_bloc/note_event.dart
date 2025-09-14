part of 'note_bloc.dart';

abstract class NoteEvent {}

class LoadNotes extends NoteEvent {
  final String? search;
  LoadNotes({this.search});
}class InitRepository extends NoteEvent {
  final User user;
  InitRepository({required this.user});
}

class AddNote extends NoteEvent {
  final Note note;
  AddNote({required this.note});
}

class EditNote extends NoteEvent {
  final Note note;
  EditNote({required this.note});
}

class RemoveNote extends NoteEvent {
  final String id;
  RemoveNote(this.id);
}

