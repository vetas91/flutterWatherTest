import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/weather.dart';

import 'model/WetherRepository.dart';
import 'pages/WeatherPage.dart';
import 'styles/StylesWeather.dart';

Future main() async {
//  debugPaintSizeEnabled = true;
  await DotEnv().load('.env');
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
          supportedLocales: [const Locale('en', 'US')],
          locale: data.savedLocale,
          theme: ThemeData(
            primaryColor: colorPrimary,
            backgroundColor: colorBackground,
            scaffoldBackgroundColor: colorBackground,
            cardColor: colorBackground,
          ),
          home: WeatherPage('Local Weather', WeatherRepository(weatherStation)),
        ));
  }
}
