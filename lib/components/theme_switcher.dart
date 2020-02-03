import 'package:first_flutter_app/bloc/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeObservable _themeObservable =
        Provider.of<ThemeObservable>(context);
    return Center(
      child: IconButton(
        icon: Icon(_themeObservable.isLight()
            ? Icons.brightness_2
            : Icons.brightness_7),
        onPressed: () {
          _themeObservable.toggle();
        },
      ),
    );
  }
}
