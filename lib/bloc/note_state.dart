part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NotesLoading extends NoteState {}

class EditNotesState extends NoteState {
  final Note note;

  EditNotesState({@required this.note});
}

class YourNotesState extends NoteState {
  final List<Note> notes;

  YourNotesState({@required this.notes});
}

class NewNoteState extends NoteState {}
