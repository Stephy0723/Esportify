import 'package:flutter/material.dart';
import '../widgets/comunidad/game_card.dart';
import 'juegos/mlbb_community_page.dart';
import 'juegos/lol_community_page.dart';
import 'juegos/valorant_community_page.dart';
import 'juegos/wild_community_page.dart';
import 'juegos/honkai_community_page.dart';

class ComunidadPage extends StatelessWidget {
  const ComunidadPage({super.key});

  final List<Map<String, dynamic>> juegos = const [
    {
      'nombre': 'Mobile Legends',
      'imagen': 'assets/comunidad/comunidad.mlbb.jpg',
      'tags': ['MOBA', '5v5', 'Mobile', 'Esports'],
      'rating': '88.2',
    },
    {
      'nombre': 'League of Legends',
      'imagen': 'assets/comunidad/comunidad.lol.jpg',
      'tags': ['MOBA', 'PC', 'Riot', 'Competitivo'],
      'rating': '91.3',
    },
    {
      'nombre': 'Valorant',
      'imagen': 'assets/comunidad/comunidad.valo.jpeg',
      'tags': ['Shooter', 'PC', 'Riot', 'Táctico'],
      'rating': '87.5',
    },
    {
      'nombre': 'Wild Rift',
      'imagen': 'assets/comunidad/comunidad.wild.jpeg',
      'tags': ['MOBA', 'Mobile', 'Riot'],
      'rating': '85.9',
    },
    {
      'nombre': 'Honkai',
      'imagen': 'assets/comunidad/comunidad.hok.jpg',
      'tags': ['Anime', 'Acción', 'Historia'],
      'rating': '90.1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: juegos.length,
        itemBuilder: (context, index) {
          final juego = juegos[index];

          return GameCard(
            nombre: juego['nombre'],
            imagen: juego['imagen'],
            tags: List<String>.from(juego['tags']),
            rating: juego['rating'],
            onTap: () {
              // ✅ Navegación a la página específica
              switch (juego['nombre']) {
                case 'Mobile Legends':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MlbbCommunityPage(),
                    ),
                  );
                  break;
                case 'League of Legends':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LolCommunityPage()),
                  );
                  break;
                case 'Valorant':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ValorantCommunityPage(),
                    ),
                  );
                  break;
                case 'Wild Rift':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WildCommunityPage(),
                    ),
                  );
                  break;
                case 'Honkai':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HonkaiCommunityPage(),
                    ),
                  );
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
