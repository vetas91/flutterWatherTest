import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherStatusIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BoxedIcon(WeatherIcons.day_sunny);
  }
}
