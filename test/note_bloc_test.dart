import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_hive/bloc/note_bloc.dart';
import 'package:notes_hive/models/note_model.dart';
import 'package:notes_hive/services/note_database.dart';

class MockNoteDatabase extends Mock implements NoteDatabase {}

void main() {
  MockNoteDatabase noteDatabase;
  NoteBloc noteBloc;
  setUp(() {
    noteDatabase = MockNoteDatabase();
    noteBloc = NoteBloc(noteDatabase);
  });

  group('Note Bloc Test', () {
    blocTest("",
        build: () {
          when(noteDatabase.addToBox(any)).thenAnswer((_) async => 1);
          when(noteDatabase.deleteFromBox(any)).thenAnswer((_) async => 1);
          when(noteDatabase.updateNote(any, any)).thenAnswer((_) async => 1);
          when(noteDatabase.getFullNote())
              .thenAnswer((_) async => [Note(), Note()]);
          return noteBloc;
        },
        act: (noteBloc) => noteBloc.add(ProfileInitialEvent()),
    expect:
    [NoteInitial(), NotesLoading(), ],
  }););}
