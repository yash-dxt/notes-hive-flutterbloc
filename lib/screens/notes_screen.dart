import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_hive/bloc/note_bloc.dart';
import 'package:notes_hive/screens/settings.dart';

import '../widgets.dart';
import 'edit_note.dart';

class NotesScreen extends StatelessWidget {
  final Color black = Color(0xFF1e2022);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButtonRefactor(),
      body: CustomScrollView(
        slivers: [
          AppBarOfPage(),
          SliverPadding(padding: EdgeInsets.all(10)),
          BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteInitial) {
                return SliverList(
                    delegate: SliverChildListDelegate([Container()]));
              }
              if (state is YourNotesState) {
                return NoteGrid(state: state);
              }
              if (state is NotesLoading) {
                return SliverList(
                    delegate:
                        SliverChildListDelegate([Center(child: Container())]));
              } else {
                return SliverList(
                    delegate: SliverChildListDelegate([Container()]));
              }
            },
          ),
        ],
      ),
    );
  }
}

class FloatingActionButtonRefactor extends StatelessWidget {
  const FloatingActionButtonRefactor({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return EditNote(
                newNote: true,
              );
            }));
          },
          child: Icon(Icons.add),
        ));
  }
}

class AppBarOfPage extends StatelessWidget {
  const AppBarOfPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color(0xFF49565e),
      title: Text(
        'Your Notes',
        style: TextStyle(color: Colors.white),
      ),
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: Container(),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            }));
          },
        )
      ],
    );
  }
}

class NoteGrid extends StatelessWidget {
  const NoteGrid({Key key, this.state}) : super(key: key);
  final YourNotesState state;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final note = state.notes[index];
        return InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return EditNote(
                note: note,
                index: index,
                newNote: false,
              );
            }));
          },
          onLongPress: () {
            showDialog(
                context: context, child: AlertDialogRefactor(index: index));
          },
          child: NoteCard(
            title: note.title,
            content: note.content,
          ),
        );
      }, childCount: state.notes.length),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
