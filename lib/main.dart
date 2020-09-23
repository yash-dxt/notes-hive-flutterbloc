import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_hive/bloc/note_bloc.dart';
import 'package:notes_hive/models/note_model.dart';
import 'package:notes_hive/screens/notes_screen.dart';
import 'package:notes_hive/services/note_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Note>(NoteAdapter());
  await Hive.openBox<Note>("Note");
  runApp(BlocProvider(
    create: (context) => NoteBloc(NoteDatabase()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(ProfileInitialEvent());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color(0xFFf0f5f9),
        cardColor: Color(0xFFc9d6df),
        primaryColor: Color(0xFFc9d6df),
        accentColor: Color(0xFF52616b),
      ),
      home: NotesScreen(),
    );
  }
}
