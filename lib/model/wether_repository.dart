import 'package:first_flutter_app/model/weather_data.dart';
import 'package:weather/weather.dart';

const String degreeCelsius = '°';

class WeatherRepository {
  WeatherRepository(this._weatherStation);

  final WeatherStation _weatherStation;

  Future<WeatherData> fetchCurrentWeather() async {
    final Weather weather = await _weatherStation.currentWeather();
    return toData(weather);
  }

  Future<List<WeatherData>> fetchForecast() async {
    final List<Weather> list = await _weatherStation.fiveDayForecast();
    return list.map(toData).toList();
  }

  Future<bool> withPermissions() async {
    return await _weatherStation.manageLocationPermission();
  }

  WeatherData toData(Weather weather) {
    return WeatherData(
      0,
      weather.areaName,
      weather.temperature.celsius.toStringAsFixed(0) + degreeCelsius,
      weather.weatherMain,
      weather.weatherIcon,
      weather.date,
    );
  }
}
