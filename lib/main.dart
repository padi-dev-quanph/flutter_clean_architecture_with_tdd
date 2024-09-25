import 'package:flutter/material.dart';
import 'package:winter_weather_app_tdd/injector.dart';
import 'package:winter_weather_app_tdd/src/presentation/weather/weather_page.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherPage(),
    );
  }
}
