import 'package:flutter/material.dart';
import 'package:weathering_app/weathering_screen.dart';

void main() {
  runApp(const MyWeatheringApp());
}

class MyWeatheringApp extends StatelessWidget {
  const MyWeatheringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const WeatheringScreenHome(),
    );
  }
}