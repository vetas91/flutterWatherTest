import 'package:first_flutter_app/model/WeatherData.dart';
import 'package:weather/weather.dart';

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

//   TODO add permissions check
//  withPermissions() async {
//
//  }

  WeatherData toData(Weather weather) {
    return WeatherData(
      weather.areaName,
      weather.temperature.celsius.toString(),
      weather.weatherMain,
      weather.weatherIcon,
    );
  }
}
