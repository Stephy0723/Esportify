import 'package:flutter/material.dart';
import '../../section_box.dart';

class JugadorSection extends StatelessWidget {
  const JugadorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _box('🎮 Equipos activos', [
      'Team Esmeralda (Shooter)',
      'Team Omega (Fighting)',
    ]);
  }

  Widget _box(String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) =>
                Text('• $item', style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
