import 'package:http/http.dart' as http;
import 'dart:convert';

const String url =
    "https://api.openweathermap.org/data/2.5/weather?q=london&appid=7ea5bee46986f62402c03be21e187948";

class Weather {
  static Uri uri = Uri.parse(url);

  static void getWeather(Duration interval) async {
    await for (final weather in weatherStream(interval)) {
      updateState(weather);
    }
  }

  static Stream<WeatherData> weatherStream(Duration interval) async* {
    while (true) {
      try {
      yield await makeWeatherShot();
      } catch (err) {
        print(err.toString());
      }
      await Future.delayed(interval);
    }
  }

  static Future<WeatherData> makeWeatherShot() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return WeatherData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static void updateState(WeatherData value) {
    print(
        "${DateTime.now().toIso8601String()} in ${value.city} right now ${value.weatherMain} and temperature of ${value.temperature} degrees");
  }
}

class WeatherData {
  final String weatherMain;
  final double temperature;
  final String city;

  WeatherData(this.weatherMain, this.temperature, this.city);

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      json['weather'][0]['main'],
      json['main']['temp'].toDouble(),
      json['name'],
    );
  }
}
