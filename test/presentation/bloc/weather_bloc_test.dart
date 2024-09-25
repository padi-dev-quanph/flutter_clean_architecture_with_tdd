
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:winter_weather_app_tdd/src/presentation/weather/weather_bloc.dart';
import 'package:winter_weather_app_tdd/src/presentation/weather/weather_event.dart';
import 'package:winter_weather_app_tdd/src/presentation/weather/weather_state.dart';
import 'package:winter_weather_app_tdd/core/error/error_handing.dart';
import 'package:winter_weather_app_tdd/src/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is successful',
      build: () {
        when(mockGetCurrentWeatherUseCase.call(params: testCityName))
            .thenAnswer((_) async => const Right(testWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherLoaded(testWeather)]);

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetCurrentWeatherUseCase.call(params: testCityName))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [WeatherLoading(), const WeatherLoadFailue('Server failure')]);
}
