import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherStatusIcon extends StatelessWidget {
  WeatherStatusIcon(this._iconKey, {this.size});

  final String _iconKey;
  final double size;

  @override
  Widget build(BuildContext context) {
    return BoxedIcon(
      WeatherIcons.fromString(_iconKey,
          // Fallback is optional, throws if not found, and not supplied.
          fallback: WeatherIcons.na),
      // Reset scale - see source code of BoxedIcon
      size: size != null && size > 0 ? size / 1.5 : null,
    );
  }
}
