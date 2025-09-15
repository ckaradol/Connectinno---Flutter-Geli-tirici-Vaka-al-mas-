part of 'note_bloc.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;
  final bool? isMore;
  final bool? isLoading;
  NoteLoaded(this.notes,  {this.isMore,this.isLoading=false,});
}

class NoteError extends NoteState {
  final String message;
  NoteError(this.message);
}