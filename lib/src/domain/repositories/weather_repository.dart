import 'package:dartz/dartz.dart';
import 'package:winter_weather_app_tdd/core/error/error_handing.dart';
import 'package:winter_weather_app_tdd/src/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}
