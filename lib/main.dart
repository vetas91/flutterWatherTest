import 'package:first_flutter_app/pages/WeatherPage.dart';
import 'package:first_flutter_app/styles/StylesWeather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(EasyLocalization(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
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
          supportedLocales: [Locale('en', 'US')],
          locale: data.savedLocale,
          theme: ThemeData(
            primaryColor: colorPrimary,
            backgroundColor: colorBackground,
            scaffoldBackgroundColor: colorBackground,
            cardColor: colorBackground,
          ),
          home: WeatherPage(title: 'Local Weather'),
        ));
  }
}
