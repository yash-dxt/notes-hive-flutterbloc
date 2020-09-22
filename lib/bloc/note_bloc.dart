import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_hive/logger_file.dart';
import 'package:notes_hive/models/note_model.dart';
import 'package:notes_hive/services/note_database.dart';

part 'note_event.dart';
part 'note_state.dart';

NoteDatabase _noteDatabase = NoteDatabase();
List<Note> _notes = [];

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is ProfileInitialEvent) {
      yield* _mapInitialEventToState();
    }
    if (event is NoteAddEvent) {
      logger.d("Note Add Event With Date: ${event.date}");
      logger.d("Notes:${_notes[0]}, ${_notes[1]},${_notes[2]}");

      yield* _mapNoteAddEventToState(
          title: event.title,
          content: event.content,
          firstCreatedDate: event.date);
    }
    if (event is NoteEditEvent) {
      logger.d("Notes:${_notes[0]}, ${_notes[1]},${_notes[2]}");

      yield* _mapNoteEditEventToState(
          title: event.title,
          content: event.content,
          index: event.index,
          lastUpdatedDate: event.date);
    }
    if (event is NoteDeleteEvent) {
      yield* _mapNoteDeleteEventToState(index: event.index);
    }
    if (event is SortNotesByUpdatedDate) {
      List<Note> listSortedByUpdatedDate = _notes;

      listSortedByUpdatedDate.sort((a, b) {
        var adate = a.lastUpdatedDate;
        var bdate = b.lastUpdatedDate;
        return adate.compareTo(bdate);
      });
      logger.d("Notes:${_notes[0]}, ${_notes[1]},${_notes[2]}");
      logger.d(
          "Sorted Notes:${listSortedByUpdatedDate[0]}, ${listSortedByUpdatedDate[1]},${listSortedByUpdatedDate[2]}");

      yield YourNotesSortedByUpdatedDate(listSortedByUpdatedDate);
    }
  }
//STREAM FUNCTIONS

//This function initialises hive and gets all the notes from DB to put it in _notes
  Stream<NoteState> _mapInitialEventToState() async* {
    yield NotesLoading();

    await Hive.initFlutter();
    Hive.registerAdapter<Note>(NoteAdapter());
    await Hive.openBox<Note>("Note");
    await _getNotes();

    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteAddEventToState(
      {@required String title,
      @required String content,
      @required DateTime firstCreatedDate}) async* {
    yield NotesLoading();
    await _addToNotes(
        title: title, content: content, firstCreatedDate: firstCreatedDate);
    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteEditEventToState(
      {@required String title,
      @required String content,
      @required int index,
      @required DateTime lastUpdatedDate}) async* {
    yield NotesLoading();
    await _updateNote(
        newTitle: title,
        newContent: content,
        index: index,
        lastUpdatedDate: lastUpdatedDate);
    yield YourNotesState(notes: _notes);
  }

  Stream<NoteState> _mapNoteDeleteEventToState({@required int index}) async* {
    yield NotesLoading();
    await _removeFromNotes(index: index);
    yield YourNotesState(notes: _notes);
  }

//HELPER FUNCTIONS

//Gets notes from Database and puts them to the list (_notes)
  Future<void> _getNotes() async {
    await _noteDatabase.getFullNote().then((value) {
      _notes = value;
    });
  }

//A new note is created! Should specify the first updated date, which will also
//be the last updated date, because it's a new note.
  Future<void> _addToNotes(
      {@required String title,
      @required String content,
      @required DateTime firstCreatedDate}) async {
    await _noteDatabase.addToBox(Note(
        title: title,
        content: content,
        firstCreatedDate: firstCreatedDate,
        lastUpdatedDate: firstCreatedDate));
    await _getNotes();
  }

//Updates a note in the Database, should specify updated note date
//Will not fiddle with the firstUpdatedDate
  Future<void> _updateNote(
      {@required int index,
      @required String newTitle,
      @required String newContent,
      @required DateTime lastUpdatedDate}) async {
    await _noteDatabase.updateNote(
        index,
        Note(
            title: newTitle,
            content: newContent,
            lastUpdatedDate: lastUpdatedDate));
    await _getNotes();
  }

//Removes the note at a specific index
  Future<void> _removeFromNotes({@required int index}) async {
    await _noteDatabase.deleteFromBox(index);
    await _getNotes();
  }
}
