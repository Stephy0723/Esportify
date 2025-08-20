import 'package:flutter/material.dart';

class SeccionesConfig extends StatelessWidget {
  final Map<String, bool> rolesActivos;

  const SeccionesConfig({super.key, required this.rolesActivos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (rolesActivos['Jugador'] == true)
            _buildCard(
              icon: Icons.sports_esports,
              title: 'Equipos activos',
              items: ['Team Esmeralda (Shooter)', 'Team Omega (Fighting)'],
            ),
          if (rolesActivos['Coach'] == true)
            _buildCard(
              icon: Icons.school,
              title: 'Equipos como Coach',
              items: ['Storm X – Coach General', 'Titan Force – Estrategia'],
            ),
          if (rolesActivos['Creador de contenido'] == true)
            _buildCard(
              icon: Icons.video_call,
              title: 'Contenido publicado',
              items: ['YouTube: Celestial Clips', 'TikTok: @celestial22'],
            ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required List<String> items,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '- $item',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
