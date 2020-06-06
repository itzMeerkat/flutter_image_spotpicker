import 'package:flutter/material.dart';
import 'package:flutter_image_spotpicker/flutter_image_spotpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImageSpotpickerExample();
  }
}

class ImageSpotpickerExample extends State<MyApp> {
  static List<Offset> points = [
    Offset(178, 152),
    Offset(185, 272),
    Offset(245, 186),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("flutter_image_map Example")),
            body: ImageSpotpicker(
              imagePath: 'assets/worldmap.png',
              imageSize: Size(698, 566),
              pins: points,
              isDebug: false,
            )));
  }
}
