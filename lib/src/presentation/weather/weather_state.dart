import 'package:equatable/equatable.dart';
import 'package:winter_weather_app_tdd/src/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherEmpty extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

final class WeatherLoadFailue extends WeatherState {
  final String message;

  const WeatherLoadFailue(this.message);

  @override
  List<Object?> get props => [message];
}
