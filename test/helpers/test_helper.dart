import 'package:mockito/annotations.dart';
import 'package:winter_weather_app_tdd/src/data/sources/remote_data_source.dart';
import 'package:winter_weather_app_tdd/src/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:winter_weather_app_tdd/src/domain/usecases/get_current_weather.dart';

@GenerateMocks(
    [WeatherRepository, WeatherRemoteDataSource, GetCurrentWeatherUseCase],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
