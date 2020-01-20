import 'package:easy_localization/easy_localization.dart';
import 'package:first_flutter_app/bloc/WeatherBlock.dart';
import 'package:flutter/material.dart';

import '../components/WeatherStatusIcon.dart';
import '../model/WetherRepository.dart';
import '../styles/StylesWeather.dart';

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
    final List<String> items = ["Test1", "2", "3", "4", "asd"];
    final data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
        data: data,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
          ),
          body: Container(
              child: Wrap(children: <Widget>[
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _renderLocation(),
                  Text(
                    'State',
                    style: textStyleWeatherStatus,
                  ),
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    final widgetEdge = constraints.maxWidth / 2;
                    return Container(
                        child: Row(children: <Widget>[
                      Container(
                          width: widgetEdge,
                          height: widgetEdge,
                          child: WeatherStatusIcon()),
                      FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            '1234',
                            style: textStyleWeatherTemperature,
                          ))
                    ]));
                  }),
                  Container(
                      height: 100,
                      child: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        final double totalWidth = constraints.maxWidth;
                        final double itemWidth =
                            ((totalWidth - 16) / items.length);
                        return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _renderListItem(itemWidth, items[index]);
                            });
                      })),
                  Text(_translateFor('loading'))
                ],
              ),
            )
          ])),
        ));
  }

  String _translateFor(String key) {
    return AppLocalizations.of(context).tr(key);
  }

  Widget _renderLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.room, color: colorLightText),
        StreamBuilder<WeatherState>(
            stream: _bloc.location,
            initialData: LocationLoadingState(),
            builder:
                (BuildContext context, AsyncSnapshot<WeatherState> snapshot) {
              return _renderLocationTitle(snapshot.data);
            })
      ],
    );
  }

  Widget _renderLocationTitle(WeatherState state) {
    String locationTitle;
    if (state is LocationLoadingState) {
      locationTitle = _translateFor('locations.loading');
    } else if (state is LocationPermissionState) {
      locationTitle = _translateFor('locations.noPermissions');
    } else if (state is LocationDataState) {
      locationTitle = "asd";
    } else {
      locationTitle = 'Lol what?';
    }
    return Text(
      locationTitle,
      textAlign: TextAlign.start,
      style: textStyleWeatherLocation,
    );
  }

  Widget _renderListItem(double itemWidth, String text) {
    return Container(
        width: itemWidth,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                'Wed, 12 AM',
                style: textStyleWeatherDay,
              )),
              WeatherStatusIcon(),
              Center(
                  child: Text(
                text,
                style: textStyleWeatherDayTemperature,
              ))
            ],
          ),
        ));
  }
}
