part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class ProfileInitialEvent extends NoteEvent {}

class NoteAddEvent extends NoteEvent {
  final String title, content;
  final DateTime date;

  NoteAddEvent(
      {@required this.date, @required this.title, @required this.content});
}

class NoteEditEvent extends NoteEvent {
  final String title, content;
  final int index;
  final DateTime date;

  NoteEditEvent(
      {@required this.date,
      @required this.title,
      @required this.content,
      @required this.index});
}

class NoteDeleteEvent extends NoteEvent {
  final int index;

  NoteDeleteEvent({@required this.index});
}

class SortNotesByUpdatedDate extends NoteEvent {}
