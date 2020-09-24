part of 'note_bloc.dart';

@immutable
abstract class NoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitialEvent extends NoteEvent {}

class NoteAddEvent extends NoteEvent {
  final String title, content;

  NoteAddEvent({@required this.title, @required this.content});
}

class NoteEditEvent extends NoteEvent {
  final String title, content;
  final int index;

  NoteEditEvent(
      {@required this.title, @required this.content, @required this.index});
}

class NoteDeleteEvent extends NoteEvent {
  final int index;

  NoteDeleteEvent({@required this.index});
}
