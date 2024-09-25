import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:winter_weather_app_tdd/core/error/exception.dart';
import 'package:winter_weather_app_tdd/src/data/models/weather_model.dart';
import '../../../core/constants/constants.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
