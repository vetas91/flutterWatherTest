import 'package:easy_localization/easy_localization.dart';
import 'package:first_flutter_app/bloc/theme.dart';
import 'package:first_flutter_app/styles/styles_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather/weather.dart';

import 'model/wether_repository.dart';
import 'pages/weather_page.dart';


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
    // ignore: always_specify_types
    final data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<ThemeObservable>(
              create: (_) => ThemeObservable(lightTheme)),
          Provider<WeatherRepository>(
            create: (_) => WeatherRepository(weatherStation),
          )
        ],
        child: AppWithInjections(),
      ),
    );
  }
}

class AppWithInjections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    final data = EasyLocalizationProvider.of(context).data;
    final ThemeObservable theme = Provider.of<ThemeObservable>(context);
    final WeatherRepository weatherRepository =
        Provider.of<WeatherRepository>(context);
    return MaterialApp(
      title: 'Weather Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //app-specific localization
        EasylocaLizationDelegate(locale: data.locale, path: 'resources/langs'),
      ],
      supportedLocales: locales,
      locale: data.savedLocale,
      theme: theme.themeData,
      home: WeatherPage('Local Weather', weatherRepository),
    );
  }
}
