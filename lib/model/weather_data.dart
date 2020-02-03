import 'db.dart';

class WeatherData {
  WeatherData(this.id, this.locationName, this.temperature, this.status,
      this.icon, this.date);

  int id;
  String locationName;
  String temperature;
  String status;
  String icon;
  DateTime date;

  WeatherData.fromJson(Map<String, dynamic> json) {
    id = json[DBCreator.id] as int;
    locationName = json[DBCreator.locationName] as String;
    temperature = json[DBCreator.temperature] as String;
    status = json[DBCreator.status] as String;
    icon = json[DBCreator.icon] as String;
    date = DateTime.parse(json[DBCreator.date] as String);
  }
}
