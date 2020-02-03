import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBCreator {
  static const String id = 'id';
  static const String locationName = 'locationName';
  static const String temperature = 'temperature';
  static const String status = 'status';
  static const String icon = 'icon';
  static const String date = 'date';

  static const String forecastTable = 'forecast';
}

const String createWeatherTableScript =
    'CREATE TABLE ${DBCreator.forecastTable}('
    '${DBCreator.id} INTEGER PRIMARY KEY,'
    '${DBCreator.locationName} TEXT,'
    '${DBCreator.temperature} TEXT,'
    '${DBCreator.status} TEXT,'
    '${DBCreator.icon} TEXT,'
    '${DBCreator.date} TEXT'
    ')';

class DB {
  Database db;

  Future<String> getPath(String dbName) async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, dbName);
    return path;
  }

  Future<void> init() async {
    final path = await getPath('weather.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      onCreate(db, version);
    });
  }

  Future<void> onCreate(Database db, int version) async {
    await createWeatherTable(db);
  }

  Future<void> createWeatherTable(Database db) async {
    await db.execute(createWeatherTableScript);
  }



}
