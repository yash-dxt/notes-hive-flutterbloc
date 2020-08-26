import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_hive/bloc/note_bloc.dart';
import 'package:notes_hive/screens/notes_screen.dart';

void main() async {
  runApp(BlocProvider(
    create: (context) => NoteBloc(),
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
