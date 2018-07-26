import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter({ this.points });

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.points != points;

}

class Signature extends StatefulWidget {
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  void _panUpdate(DragUpdateDetails details) {
    RenderBox referenceBox = context.findRenderObject();
    Offset localPosition = referenceBox.globalToLocal(details.globalPosition);

    setState(() {
      _points = new List.from(_points)..add(localPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onPanUpdate: _panUpdate,
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
        CustomPaint(painter: SignaturePainter(points: _points))
      ],
    );
  }
}
