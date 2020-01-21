import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../components/weather_status_icon.dart';
import '../model/weather_data.dart';
import '../styles/styles_weather.dart';

class WeatherForecast extends StatelessWidget {
  WeatherForecast(this._items);

  final List<WeatherData> _items;

  final DateFormat dateFormat = DateFormat('EEE, hh a');

  Widget _renderListItem(WeatherData data) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Center(
              child: Text(
            dateFormat.format(data.date),
            style: textStyleWeatherDay,
          )),
          WeatherStatusIcon(data.icon),
          Center(
              child: Text(
            data.temperature,
            style: textStyleWeatherDayTemperature,
          ))
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index) {
            return _renderListItem(_items[index]);
          });
    });
  }
}
