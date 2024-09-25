import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:winter_weather_app_tdd/src/domain/entities/weather.dart';
import 'package:winter_weather_app_tdd/src/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'Hanoi',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04d',
    temperature: 307.15,
    pressure: 1001,
    humidity: 80,
  );

  const testCityName = 'Ha noi';

  test('Should get current weather detail from repository', () async {
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    final result = await getCurrentWeatherUseCase.call(params: testCityName);

    expect(result, const Right(testWeatherDetail));
  });
}
