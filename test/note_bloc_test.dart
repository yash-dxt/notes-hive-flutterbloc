import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_hive/bloc/note_bloc.dart';
import 'package:notes_hive/models/note_model.dart';
import 'package:notes_hive/services/note_database.dart';

class MockNoteDatabase extends Mock implements NoteDatabase {}

void main() {
  MockNoteDatabase noteDatabase;
  setUp(() {
    noteDatabase = MockNoteDatabase();
  });

  group('Note Bloc Test', () {
    List<Note> notes = [];

    blocTest("When Profile Initial Event is Triggered",
        build: () {
          when(noteDatabase.getFullNote()).thenAnswer((_) async => notes);
          return NoteBloc(noteDatabase);
        },
        act: (noteBloc) => noteBloc.add(ProfileInitialEvent()),
        expect: [NotesLoading(), YourNotesState(notes: notes)]);

    blocTest("When Add New Note Event is Triggered",
        build: () {
          when(noteDatabase.getFullNote()).thenAnswer((_) async => notes);
          return NoteBloc(noteDatabase);
        },
        act: (noteBloc) =>
            noteBloc.add(NoteAddEvent(title: "title", content: "content!")),
        expect: [NotesLoading(), YourNotesState(notes: notes)]);
    blocTest("When Profile Delete Note Event is Triggered",
        build: () {
          when(noteDatabase.getFullNote()).thenAnswer((_) async => notes);
          return NoteBloc(noteDatabase);
        },
        act: (noteBloc) => noteBloc.add(NoteDeleteEvent(index: 1)),
        expect: [NotesLoading(), YourNotesState(notes: notes)]);
    blocTest("When Profile Edit Note Event is Triggered",
        build: () {
          when(noteDatabase.getFullNote()).thenAnswer((_) async => notes);
          return NoteBloc(noteDatabase);
        },
        act: (noteBloc) => noteBloc
            .add(NoteEditEvent(title: "title", content: "content", index: 1)),
        expect: [NotesLoading(), YourNotesState(notes: notes)]);
  });
}
