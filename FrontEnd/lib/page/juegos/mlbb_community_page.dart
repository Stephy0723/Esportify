import 'package:flutter/material.dart';

class MlbbCommunityPage extends StatelessWidget {
  const MlbbCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EBF1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Encabezado visual: logo y personaje
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo del juego (izquierda)
                  Image.asset(
                    'assets/icons/mlbb..logo.png', // ← CORREGIDO
                    height: 80,
                  ),

                  const Spacer(),

                  // Personaje (derecha)
                  Image.asset(
                    'assets/game/mlbb.game.png',
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                'Mobile Legends',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'A VISUAL EVOLUTION',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 16),

              // TAGS con colores
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _Tag(label: 'MOBA', color: Color(0xFFB388FF)),
                  _Tag(label: '5v5', color: Color(0xFF80DEEA)),
                  _Tag(label: 'Mobile', color: Color(0xFFFFAB91)),
                  _Tag(label: 'Esports', color: Color(0xFFA5D6A7)),
                  _Tag(label: 'Moonton', color: Color(0xFFFFF59D)),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Mobile Legends: Bang Bang es un juego de tipo MOBA donde dos equipos de cinco jugadores se enfrentan para destruir la base enemiga. Cada jugador elige un héroe con habilidades únicas, y el trabajo en equipo es esencial para lograr la victoria. Desde su lanzamiento, MLBB ha sido pionero en el ámbito de los esports móviles, con torneos internacionales, actualizaciones visuales constantes y una comunidad en crecimiento. Su sistema de juego rápido, controles optimizados para móviles y variedad de personajes lo convierten en uno de los títulos más influyentes del gaming moderno.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              // Zona inferior vacía
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Contenido futuro aquí...',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
