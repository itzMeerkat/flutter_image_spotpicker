import 'package:flutter/material.dart';

import 'image_spotpicker_painter.dart';

class ImageSpotpicker extends StatefulWidget {
  final String imagePath;
  final List<Map<String, double>> pins;
  final Size imageSize;
  final bool isDebug;
  final double pinSize;

  ImageSpotpicker(
      {Key key,
      @required this.imagePath,
      @required this.imageSize,
      @required this.pins,
      this.isDebug = false,
      this.pinSize = 50})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageSpotpickerState();
  }
}

class ImageSpotpickerState extends State<ImageSpotpicker> {
  bool isOnPin(double cx, double cy, Map<String, double> pinPos, double actualPinSize) {
    var halfPinSize = actualPinSize / 2;
    double dx = cx - pinPos['x'];
    double dy = pinPos['y'] - cy;
    if (dx < halfPinSize &&
        dy < actualPinSize &&
        dx > -halfPinSize &&
        dy > 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (details) {
          RenderBox b = context.findRenderObject();
          double widthMul = widget.imageSize.width / b.size.width;
          double heightMul = widget.imageSize.height / b.size.height;
          Offset locPos = details.localPosition;
          double lx = locPos.dx * widthMul, ly = locPos.dy * heightMul;
          //print("$widthMul, $heightMul");
          //print(locPos);
          //print("DASADSASD");
          for (int i = 0; i < widget.pins.length; i++) {
            if (isOnPin(lx, ly, widget.pins[i], widget.pinSize * widthMul)) {
              widget.pins.removeAt(i);
              setState(() {});
              return;
            }
          }
          //print(locPos);
          widget.pins.add(<String,double>{'x':lx,'y':ly});
          setState(() {});
        },
        child: CustomPaint(
            child: Image.asset(widget.imagePath),
            foregroundPainter: ImageSpotpickerPainter(
                pinSize: widget.pinSize,
                pins: widget.pins,
                rawSize: widget.imageSize,
                debug: widget.isDebug)));
  }
}
