import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:winter_weather_app_tdd/core/error/error_handing.dart';
import 'package:winter_weather_app_tdd/src/data/sources/remote_data_source.dart';
import 'package:winter_weather_app_tdd/src/domain/entities/weather.dart';
import 'package:winter_weather_app_tdd/src/domain/repositories/weather_repository.dart';

import '../../../core/error/exception.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(city);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
