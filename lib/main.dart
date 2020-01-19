import 'package:first_flutter_app/pages/WeatherPage.dart';
import 'package:first_flutter_app/styles/StylesWeather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Demo',
      theme: ThemeData(
        primaryColor: colorPrimary,
        backgroundColor: colorBackground,
        scaffoldBackgroundColor: colorBackground,
        cardColor: colorBackground,
      ),
      home: WeatherPage(title: 'Local Weather'),
    );
  }
}
