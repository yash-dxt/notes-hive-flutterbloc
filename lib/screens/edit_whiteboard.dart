import 'package:flutter/material.dart';

class WhiteBoard extends StatelessWidget {
  final _offSetsList = <Offset>[]; //This is final and you can add and remove
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
      body: GestureDetector(
        onPanStart: (details) {
          _offSetsList.add(details.globalPosition);
        },
        child: Center(
          child: CustomPaint(
            painter: WhiteBoardPainter(_offSetsList),
            child: Container(
              color: Colors.white,
              height: 500,
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}

class WhiteBoardPainter extends CustomPainter {
  final offSets;

  WhiteBoardPainter(this.offSets) : super();
  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawPaint(paint(canvas, size))
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
