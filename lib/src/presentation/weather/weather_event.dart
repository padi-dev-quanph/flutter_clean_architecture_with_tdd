import 'package:equatable/equatable.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

final class OnCityChanged extends WeatherEvent {
  final String cityName;

  const OnCityChanged(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
