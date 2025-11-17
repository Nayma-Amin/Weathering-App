import 'package:flutter/material.dart';

class ForecastCardItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData weatherIcon;

  const ForecastCardItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
                    elevation: 10,
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            time,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Icon(
                            weatherIcon,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            temperature,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
  }
}