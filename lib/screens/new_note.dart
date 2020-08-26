import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_hive/bloc/note_bloc.dart';

class NewNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String title = '';
    String content = '';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'New Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF5b696f),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text('ADD'),
            onPressed: () {
              print('$title' '  ' '$content');
              if (_formKey.currentState.validate()) {
                BlocProvider.of<NoteBloc>(context)
                    .add(NoteAddEvent(title: title, content: content));

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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter some text';
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter some text';
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
