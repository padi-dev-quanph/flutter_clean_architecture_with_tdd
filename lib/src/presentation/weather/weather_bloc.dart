import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:winter_weather_app_tdd/src/presentation/weather/weather_event.dart';
import 'package:winter_weather_app_tdd/src/presentation/weather/weather_state.dart';
import 'package:winter_weather_app_tdd/src/domain/usecases/get_current_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result =
            await _getCurrentWeatherUseCase.call(params: event.cityName);
        result.fold(
          (failure) {
            emit(WeatherLoadFailue(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
