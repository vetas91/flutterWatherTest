import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'db.dart';
import 'weather_data.dart';

class LocalWeatherRepository {
  final Database _db;

  LocalWeatherRepository(this._db);

  Future<List<WeatherData>> getForecast() async {
    final String sql = 'SELECT * FROM ${DBCreator.forecastTable}';
    final List<Map> data = await _db.rawQuery(sql);
    List<WeatherData> forecast = List(data.length);
    return forecast;
  }
}
