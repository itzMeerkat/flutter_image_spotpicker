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
  static List<Map<String, double>> points = [
    {'x': 178, 'y': 152},
    {'x': 185, 'y': 272},
    {'x': 245, 'y': 186},
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
              isDebug: true,
            )));
  }
}
