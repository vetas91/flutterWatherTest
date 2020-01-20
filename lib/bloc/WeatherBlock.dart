import 'dart:async';

import '../model/WeatherData.dart';
import '../model/WetherRepository.dart';
import 'BaseBloc.dart';

class WeatherBloc implements BaseBloc {
  WeatherBloc(this._weatherRepository);

  final WeatherRepository _weatherRepository;

  final StreamController<WeatherState> _locationStreamController =
      StreamController<WeatherState>();

  Stream<WeatherState> get location => _locationStreamController.stream;

  void loadLocation() {
    _locationStreamController.sink.add(WeatherState._dataLoading());
    _weatherRepository.fetchCurrentWeather().then((WeatherData weather) {
      _locationStreamController.sink.add(WeatherState._locationData(weather));
    });
  }

  @override
  void dispose() {
    _locationStreamController.close();
  }
}

// Turn on internet
// Turn on location permission
// Turn on location
// Loading data
// Fetching location
// Data display

class WeatherState {
  WeatherState();

  factory WeatherState._locationPermissions() = LocationPermissionState;

  factory WeatherState._dataLoading() = LocationLoadingState;

  factory WeatherState._locationData(WeatherData data) = LocationDataState;
}

class LocationPermissionState extends WeatherState {}

class LocationLoadingState extends WeatherState {}

class LocationDataState extends WeatherState {
  LocationDataState(this.data);

  final WeatherData data;
}
