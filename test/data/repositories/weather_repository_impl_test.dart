import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:winter_weather_app_tdd/core/error/error_handing.dart';
import 'package:winter_weather_app_tdd/core/error/exception.dart';
import 'package:winter_weather_app_tdd/src/data/models/weather_model.dart';
import 'package:winter_weather_app_tdd/src/data/repositories/weather_repository_impl.dart';
import 'package:winter_weather_app_tdd/src/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group('get current weather', () {
    test(
        'should return current weather when a call to data source is successful',
        () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(
          result, equals(const Left(ServerFailure('An error has occurred'))));
    });

    test('should return connection failure when the device has no internet',
        () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
