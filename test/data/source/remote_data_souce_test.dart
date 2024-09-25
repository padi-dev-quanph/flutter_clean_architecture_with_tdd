import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:winter_weather_app_tdd/core/constants/constants.dart';
import 'package:winter_weather_app_tdd/core/error/exception.dart';
import 'package:winter_weather_app_tdd/src/data/models/weather_model.dart';
import 'package:winter_weather_app_tdd/src/data/sources/remote_data_source.dart';
import 'package:http/http.dart' as http;
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';

  group('Get current weather', () {
    test('should return weather model when the response code is 200', () async {
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      expect(result, isA<WeatherModel>());
    });

    test(
        'Should throw a server exception when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result =
          weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
