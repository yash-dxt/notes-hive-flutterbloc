import 'package:flutter/material.dart';
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
