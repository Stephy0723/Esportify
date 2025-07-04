// lib/widgets/comunidad/top_competidores_slider.dart

import 'package:flutter/material.dart';

class TopCompetidoresSlider extends StatelessWidget {
  final List<Map<String, String>> competidores;
  const TopCompetidoresSlider({super.key, required this.competidores});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🏆 Top Competidores', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: competidores.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final c = competidores[index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(c['foto'] ?? ''),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c['nombre'] ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    c['logro'] ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
