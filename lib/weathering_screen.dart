import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathering_app/additional_info.dart';
import 'package:weathering_app/api.dart';
import 'package:weathering_app/forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatheringScreenHome extends StatefulWidget {
  const WeatheringScreenHome({
    super.key,
  });

  @override
  State<WeatheringScreenHome> createState() => _WeatheringScreenHomeState();
}

class _WeatheringScreenHomeState extends State<WeatheringScreenHome> {
  late Future<Map<String, dynamic>> weather ;
  
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
    String city = 'Dhaka';
    final result = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city,bangladesh&APPID=$openWeatherAPIKey',
      ),
    );

    
    final data = jsonDecode(result.body);

    
    if (data['cod'] != '200') {
      throw data['Unexpected error occurred'];
    }

    return data;
      

    } catch (e) {
      throw e.toString();
  }
}

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weathering App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white,),
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error.toString()}'),
              );
            }

          final data = snapshot.data!;

          final currentData = data['list'][0];

          final currentTemperature = (currentData['main']['temp'] - 273.15).toDouble();
          final currentSkyView = currentData['weather'][0]['main'];
          final currentPressure = currentData['main']['pressure'];
          final currentWind = currentData['wind']['speed'];
          final currentHumidity = currentData['main']['humidity'];

          return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.blue.shade700.withOpacity(0.5),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              '${currentTemperature.toStringAsFixed(1)} °C',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Icon(
                              currentSkyView == 'Clouds' || currentSkyView == 'Rain' ?
                              Icons.cloud: Icons.sunny,
                              size: 80,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              currentSkyView,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Weather Forecast',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 39,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final forecastCardItem = data['list'][index + 1];
                    final temp = (forecastCardItem['main']['temp'] - 273.15).toStringAsFixed(1);
                    final icon = forecastCardItem['weather'][0]['main'];
                    final time = DateTime.parse(forecastCardItem['dt_txt'].toString());
                    return ForecastCardItem(
                        time: DateFormat.j().format(time),
                        temperature: '$temp °C',
                        weatherIcon: icon == 'Clouds' || icon == 'Rain' ? 
                        Icons.cloud: Icons.sunny,
                       );
                  },
                ),
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfo(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: '${currentHumidity.toString()} %',
                  ),
                  AdditionalInfo(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: '${currentWind.toString()} mph',
                  ),
                  AdditionalInfo(
                    icon: Icons.thermostat,
                    label: 'Pressure',
                    value: '${currentPressure.toString()} MPa',
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
        },
      ),
    );
  }
}