import 'package:flutter/material.dart';

class ImageSpotpickerPainter extends CustomPainter {
  final List<Offset> pins;
  final Paint blackPaint = Paint()
    ..color = Color.fromRGBO(255, 0, 0, 1)
    ..strokeWidth = 5;
  final Size rawSize;
  final double pinSize;
  bool debug;
  TextPainter pinPainter = TextPainter(textDirection: TextDirection.rtl);

  final IconData pinIcon = Icons.place;
  ImageSpotpickerPainter(
      {@required this.pins,
      @required this.rawSize,
      this.debug = false,
      @required this.pinSize}) {
    pinPainter.text = TextSpan(
        text: String.fromCharCode(pinIcon.codePoint),
        style: TextStyle(
            fontSize: this.pinSize,
            fontFamily: pinIcon.fontFamily,
            color: Colors.lightBlue));
    pinPainter.layout();
  }

  @override
  void paint(Canvas canvas, Size size) {
    //print("Paint size $size");
    double hScale = size.height / rawSize.height;
    double wScale = size.width / rawSize.width;

    double scale;
    double fitOffsetX = 0.0, fitOffsetY = 0.0;
    if ((wScale - 1.0).abs() > (hScale - 1.0).abs()) {
      scale = wScale;
      fitOffsetY = (size.height - this.rawSize.height * scale) / 2;
    } else {
      scale = hScale;
      fitOffsetX = (size.width - this.rawSize.width * scale) / 2;
    }

    if (debug == true) {
      canvas.drawLine(Offset(0.0, 0.0), Offset(size.width, 0.0), blackPaint);
      canvas.drawLine(Offset(0.0, 0.0), Offset(0.0, size.height), blackPaint);

      canvas.drawLine(
          Offset(size.width, 0.0), Offset(size.width, size.height), blackPaint);
      canvas.drawLine(Offset(0.0, size.height), Offset(size.width, size.height),
          blackPaint);
    }

    canvas.translate(fitOffsetX, fitOffsetY);
    canvas.scale(scale);

    for (int i = 0; i < pins.length; i++) {
      Offset paintOrigin =
          Offset(pins[i].dx - pinSize / 2, pins[i].dy - pinSize);
      if (debug == true) {
        canvas.drawRect(
            Rect.fromPoints(
                paintOrigin, paintOrigin.translate(pinSize, pinSize)),
            blackPaint);
      }
      pinPainter.paint(canvas, paintOrigin);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
