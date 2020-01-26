import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/weather.dart';

import 'model/wether_repository.dart';
import 'pages/weather_page.dart';
import 'styles/styles_weather.dart';

const List<Locale> locales = <Locale>[Locale('en', 'US')];

Future main() async {
//  debugPaintSizeEnabled = true;
  await DotEnv().load();
  runApp(EasyLocalization(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final WeatherStation weatherStation =
        WeatherStation(DotEnv().env['WEATHER_API_KEY']);
    final data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
        data: data,
        child: MaterialApp(
          title: 'Weather Demo',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            //app-specific localization
            EasylocaLizationDelegate(
                locale: data.locale, path: 'resources/langs'),
          ],
          supportedLocales: locales,
          locale: data.savedLocale,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: WeatherPage('Local Weather', WeatherRepository(weatherStation)),
        ));
  }
}
