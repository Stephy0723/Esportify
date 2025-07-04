import 'package:flutter/material.dart';

Widget styledBox(String titulo, List<String> items) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text('- $e', style: const TextStyle(color: Colors.white70)),
          ),
        ),
      ],
    ),
  );
}
