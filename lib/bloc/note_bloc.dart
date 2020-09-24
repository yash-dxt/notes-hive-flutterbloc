import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes_hive/models/note_model.dart';
import 'package:notes_hive/services/note_database.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDatabase _noteDatabase;
  List<Note> _notes = [];
  NoteBloc(this._noteDatabase) : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is ProfileInitialEvent) {
      yield* _mapInitialEventToState();
    }
    if (event is NoteAddEvent) {
      yield* _mapNoteAddEventToState(
          title: event.title, content: event.content);
    }
    if (event is NoteEditEvent) {
      yield* _mapNoteEditEventToState(
          title: event.title, content: event.content, index: event.index);
    }
    if (event is NoteDeleteEvent) {
      yield* _mapNoteDeleteEventToState(index: event.index);
    }
  }
//STREAM FUNCTIONS

  Stream<NoteState> _mapInitialEventToState() async* {
    yield NotesLoading();

    await _getNotes();

    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteAddEventToState(
      {String title, String content}) async* {
    yield NotesLoading();
    await _addToNotes(title: title, content: content);
    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteEditEventToState(
      {String title, String content, int index}) async* {
    yield NotesLoading();
    await _updateNote(newTitle: title, newContent: content, index: index);
    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteDeleteEventToState({int index}) async* {
    yield NotesLoading();
    await _removeFromNotes(index: index);
    _notes.sort((a, b) {
      var aDate = a.title;
      var bDate = b.title;
      return aDate.compareTo(bDate);
    });
    yield YourNotesState(notes: _notes);
  }

//HELPER FUNCTIONS

  Future<void> _getNotes() async {
    await _noteDatabase.getFullNote().then((value) {
      _notes = value;
    });
  }

  Future<void> _addToNotes({String title, String content}) async {
    await _noteDatabase.addToBox(Note(title: title, content: content));
    await _getNotes();
  }

  Future<void> _updateNote(
      {int index, String newTitle, String newContent}) async {
    await _noteDatabase.updateNote(
        index, Note(title: newTitle, content: newContent));
    await _getNotes();
  }

  Future<void> _removeFromNotes({int index}) async {
    await _noteDatabase.deleteFromBox(index);
    await _getNotes();
  }
}
