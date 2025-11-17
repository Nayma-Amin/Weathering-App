import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    });

  @override
  Widget build(BuildContext context) {
    return Card(
                    elevation: 10,
                    child: Container(
                      width: 115,
                      height: 100,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                           Icon(
                            icon,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5),
                           Text(
                            label,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                          ),
                          ),
                          
                          const SizedBox(height: 5),
                          Text(
                            value,
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