import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/note_bloc.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({this.title, this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final Color black = Color(0xFF1e2022);

    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
          child: Column(
            children: [
              Text(
                '$title',
                style: TextStyle(
                    color: black,
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: .5,
                width: double.infinity,
                color: black,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  '$content',
                  style: TextStyle(
                      color: black,
                      fontSize: 14,
                      wordSpacing: 1.25,
                      letterSpacing: 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AlertDialogRefactor extends StatelessWidget {
  const AlertDialogRefactor({Key key, this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete?',
        style: TextStyle(color: Color(0xFF49565e)),
      ),
      actions: [
        FlatButton(
            child: Text(
              'YES',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              BlocProvider.of<NoteBloc>(context)
                  .add(NoteDeleteEvent(index: index));
              Navigator.pop(context);
            }),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: TextStyle(color: Color(0xFF49565e)),
            ))
      ],
    );
  }
}
