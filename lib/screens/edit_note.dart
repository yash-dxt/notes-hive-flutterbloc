import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_hive/bloc/note_bloc.dart';
import 'package:notes_hive/models/note_model.dart';

class EditNote extends StatelessWidget {
  EditNote({this.note, this.index, @required this.newNote});
  final bool newNote;
  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String title = note != null ? note.title : "";
    String content = note != null ? note.content : "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          newNote ? 'New Note' : 'Edit Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF5b696f),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text(newNote ? 'ADD' : 'UPDATE'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                newNote
                    ? BlocProvider.of<NoteBloc>(context).add(NoteAddEvent(
                        title: title, content: content, date: DateTime.now()))
                    : BlocProvider.of<NoteBloc>(context).add(NoteEditEvent(
                        title: title,
                        content: content,
                        index: index,
                        date: DateTime.now()));
                Navigator.pop(context);
              }
            },
          )),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    initialValue: newNote ? '' : note.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the Note title';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      title = text;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black38),
                      border: OutlineInputBorder(),
                      labelText: 'Note Title',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    initialValue: newNote ? '' : note.content,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the Note body!';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      content = text;
                    },
                    maxLines: 90,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
      ),
    );
  }
}
