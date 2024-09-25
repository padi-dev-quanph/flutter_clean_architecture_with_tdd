import 'package:get_it/get_it.dart';
import 'package:winter_weather_app_tdd/src/presentation/weather/weather_bloc.dart';
import 'package:winter_weather_app_tdd/src/data/repositories/weather_repository_impl.dart';
import 'package:winter_weather_app_tdd/src/data/sources/remote_data_source.dart';
import 'package:winter_weather_app_tdd/src/domain/repositories/weather_repository.dart';
import 'package:winter_weather_app_tdd/src/domain/usecases/get_current_weather.dart';
import 'package:http/http.dart' as http;

final injector = GetIt.instance;

void initializeDependencies() {
  // external
  injector.registerLazySingleton(() => http.Client());

  // data source
  injector.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: injector(),
    ),
  );

  // repository
  injector.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: injector()),
  );

  // usecase
  injector.registerLazySingleton(() => GetCurrentWeatherUseCase(injector()));

  // bloc
  injector.registerFactory(() => WeatherBloc(injector()));
}
