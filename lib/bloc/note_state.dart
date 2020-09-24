part of 'note_bloc.dart';

@immutable
abstract class NoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NotesLoading extends NoteState {}

class EditNotesState extends NoteState {
  final Note note;

  EditNotesState({@required this.note});
  @override
  List<Object> get props => [note];
}

class YourNotesState extends NoteState {
  final List<Note> notes;

  YourNotesState({@required this.notes});
  @override
  List<Object> get props => [notes];
}

class NewNoteState extends NoteState {}
