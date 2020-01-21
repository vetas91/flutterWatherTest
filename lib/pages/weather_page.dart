import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../bloc/weather_block.dart';
import '../components/weather_forecast.dart';
import '../components/weather_status_icon.dart';
import '../model/weather_data.dart';
import '../model/wether_repository.dart';
import '../styles/styles_weather.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage(this._title, this._weatherRepository);

  final String _title;
  final WeatherRepository _weatherRepository;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherBloc _bloc;

  @override
  void initState() {
    _bloc = WeatherBloc(widget._weatherRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    _bloc.loadData();
    return EasyLocalizationProvider(
        data: data,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
          ),
          body: Container(
              child: Wrap(children: <Widget>[
            Card(
                child: StreamBuilder<WeatherState>(
                    stream: _bloc.weather,
                    initialData: DataLoadingState(),
                    builder: (BuildContext context,
                        AsyncSnapshot<WeatherState> snapshot) {
                      if (snapshot.data is LocationPermissionState) {
                        return _renderNoPermission();
                      }
                      if (snapshot.data is DataLoadingState) {
                        return _renderLoading();
                      }
                      if (snapshot.data is WeatherDataState) {
                        return renderDataState(
                            snapshot.data as WeatherDataState);
                      }

                      return const Center(child: CircularProgressIndicator());
                    })),
          ])),
        ));
  }

  String _translateFor(String key) {
    return AppLocalizations.of(context).tr(key);
  }

  Widget _renderNoPermission() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _translateFor('locations.noPermissions'),
              style: textStyleWeatherDayTemperature,
            )));
  }

  Widget _renderLoading() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_translateFor('locations.loading'),
                style: textStyleWeatherDayTemperature)));
  }

  Widget _renderLocation(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.room, color: colorLightText),
        Text(
          title,
          textAlign: TextAlign.start,
          style: textStyleWeatherLocation,
        )
      ],
    );
  }

  Widget renderDataState(WeatherDataState weatherState) {
    final WeatherData weatherData = weatherState.data;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _renderLocation(weatherData.locationName),
          Text(
            weatherData.status,
            style: textStyleWeatherStatus,
          ),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            final double widgetEdge = constraints.maxWidth / 2;
            return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  WeatherStatusIcon(
                    weatherData.icon,
                    size: widgetEdge,
                  ),
                  FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        weatherData.temperature,
                        style: textStyleWeatherTemperature
                            .merge(TextStyle(fontSize: widgetEdge * 0.5)),
                      ))
                ]));
          }),
          Divider(),
          Container(height: 95, child: WeatherForecast(weatherState.forecast))
        ]);
  }
}
