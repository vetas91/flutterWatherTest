import 'dart:async';

import '../model/weather_data.dart';
import '../model/wether_repository.dart';
import 'base_bloc.dart';

class WeatherBloc implements BaseBloc {
  WeatherBloc(this._weatherRepository);

  final WeatherRepository _weatherRepository;

  final StreamController<WeatherState> _locationStreamController =
      StreamController<WeatherState>.broadcast();

  Stream<WeatherState> get weather =>
      _locationStreamController.stream.asBroadcastStream();

  void loadData() {
    _locationStreamController.sink.add(WeatherState._dataLoading());
    _weatherRepository.withPermissions().then((bool value) {
      if (value) {
        _loadWeather();
      } else {
        _locationStreamController.sink.add(WeatherState._locationPermissions());
      }
    }).catchError((Object error) {
      _locationStreamController.sink.add(WeatherState._locationPermissions());
    });
  }

  void _loadWeather() {
    _weatherRepository.fetchCurrentWeather().then((WeatherData data) {
      _loadForecast(data);
    }).catchError((Object error) {
      // Ignore ?
    });
  }

  void _loadForecast(WeatherData data) {
    _weatherRepository.fetchForecast().then((List<WeatherData> forecast) {
      _locationStreamController.sink
          .add(WeatherState._weatherData(data, forecast));
    }).catchError((Object error) {
      // Ignore ?
    });
  }

  @override
  void dispose() {
    _locationStreamController.close();
  }
}

class WeatherState {
  WeatherState();

  factory WeatherState._locationPermissions() = LocationPermissionState;

  factory WeatherState._dataLoading() = DataLoadingState;

  factory WeatherState._weatherData(
      WeatherData data, List<WeatherData> forecast) = WeatherDataState;
}

class LocationPermissionState extends WeatherState {}

class DataLoadingState extends WeatherState {}

class WeatherDataState extends WeatherState {
  WeatherDataState(this.data, this.forecast);

  WeatherData data;
  List<WeatherData> forecast;
}
