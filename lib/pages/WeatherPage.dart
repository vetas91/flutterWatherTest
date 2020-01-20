import 'package:first_flutter_app/components/WeatherStatusIcon.dart';
import 'package:first_flutter_app/styles/StylesWeather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "Test1",
      "2",
      "3",
      "4",
      "5555555555555555555555555555555555555555"
    ];
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
        data: data,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
              child: Wrap(children: <Widget>[
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.room, color: colorLightText),
                      Text(
                        'Location',
                        textAlign: TextAlign.start,
                        style: textStyleWeatherLocation,
                      ),
                    ],
                  ),
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
                        double totalWidth = constraints.maxWidth;
                        double itemWidth = ((totalWidth - 16) / items.length);
                        return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return renderListItem(itemWidth, items[index]);
                            });
                      })),
                  Text(AppLocalizations.of(context).tr('loading'))
                ],
              ),
            )
          ])),
        ));
  }

  Widget renderListItem(num itemWidth, String text) {
    return Container(
        width: itemWidth,
        child: Padding(
          padding: EdgeInsets.all(2.0),
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
