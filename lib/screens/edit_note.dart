import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_hive/bloc/note_bloc.dart';
import 'package:notes_hive/models/note_model.dart';

class EditNote extends StatefulWidget {
  EditNote({this.note, this.index, @required this.newNote});
  final bool newNote;
  final Note note;
  final int index;

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.note != null ? widget.note.title : "";
    String content = widget.note != null ? widget.note.content : "";
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController(text: title);
    final _contentController = TextEditingController(text: content);

    Future<bool> _onWillPop() async {
      if (_titleController.text == title ||
          _contentController.text == content) {
        return showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Unsaved data will be lost.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false;
      } else {
        return true;
      }
    }

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            widget.newNote ? 'New Note' : 'Edit Note',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF5b696f),
        ),
        floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text(widget.newNote ? 'ADD' : 'UPDATE'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  widget.newNote
                      ? BlocProvider.of<NoteBloc>(context).add(NoteAddEvent(
                          title: _titleController.text,
                          content: _contentController.text))
                      : BlocProvider.of<NoteBloc>(context).add(NoteEditEvent(
                          title: _titleController.text,
                          content: _contentController.text,
                          index: widget.index));
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
                  NoteTitle(titleController: _titleController),
                  SizedBox(
                    height: 20,
                  ),
                  NoteBody(contentController: _contentController),
                  SizedBox(
                    height: 10,
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class NoteTitle extends StatelessWidget {
  const NoteTitle({
    Key key,
    @required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _titleController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter the note title';
          }
          return null;
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black38),
          border: OutlineInputBorder(),
          labelText: 'Note Title',
        ),
      ),
    );
  }
}

class NoteBody extends StatelessWidget {
  const NoteBody({
    Key key,
    @required TextEditingController contentController,
  })  : _contentController = contentController,
        super(key: key);

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _contentController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter the note body!';
          }
          return null;
        },
        maxLines: 90,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
