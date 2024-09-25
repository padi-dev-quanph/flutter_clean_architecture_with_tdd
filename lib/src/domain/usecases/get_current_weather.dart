import 'package:dartz/dartz.dart';
import 'package:winter_weather_app_tdd/core/error/error_handing.dart';
import 'package:winter_weather_app_tdd/core/usecases/usecase.dart';
import 'package:winter_weather_app_tdd/src/domain/entities/weather.dart';
import 'package:winter_weather_app_tdd/src/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase
    extends UseCase<Either<Failure, WeatherEntity>, String> {
  final WeatherRepository _weatherRepository;
  GetCurrentWeatherUseCase(this._weatherRepository);

  @override
  Future<Either<Failure, WeatherEntity>> call({String? params}) async {
    return await _weatherRepository.getCurrentWeather(params!);
  }
}
