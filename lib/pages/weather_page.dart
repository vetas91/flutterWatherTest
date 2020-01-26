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
                color: Theme.of(context).primaryColor,
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _translateFor('locations.noPermissions'),
                    style: Theme.of(context).primaryTextTheme.title,
                  ),
                  RaisedButton(
                    child: Text(_translateFor('retry')),
                    onPressed: () {
                      _bloc.loadData();
                    },
                  )
                ])));
  }

  Widget _renderLoading() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  _translateFor('locations.loading'),
                  style: Theme.of(context).primaryTextTheme.title,
                ),
                const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator())
              ],
            )));
  }

  Widget _renderLocation(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.room, color: colorLight),
        Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.title,
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
            style: Theme.of(context).textTheme.body1,
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
                        style: Theme.of(context)
                            .primaryTextTheme
                            .title
                            .merge(TextStyle(fontSize: widgetEdge * 0.5)),
                      ))
                ]));
          }),
          const Divider(),
          Container(height: 95, child: WeatherForecast(weatherState.forecast))
        ]);
  }
}
