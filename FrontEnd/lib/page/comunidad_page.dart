import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../widgets/comunidad/game_card.dart';
import 'juegos/mlbb_community_page.dart';
import 'juegos/lol_community_page.dart';
import 'juegos/valorant_community_page.dart';
import 'juegos/wild_community_page.dart';
import 'juegos/honkai_community_page.dart';
=======
>>>>>>> bebbbff (Progreso actual de registro y validaciones)

class ComunidadPage extends StatelessWidget {
  const ComunidadPage({super.key});

<<<<<<< HEAD
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
=======
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> comunidades = [
      {
        "nombre": "Mobile Legends DR",
        "juego": "Mobile Legends",
        "seguidores": 1200,
      },
      {"nombre": "Valorant Elite", "juego": "Valorant", "seguidores": 950},
      {
        "nombre": "League Latam",
        "juego": "League of Legends",
        "seguidores": 1430,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Comunidades"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: comunidades.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final comunidad = comunidades[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.videogame_asset, color: Colors.white),
              ),
              title: Text(comunidad["nombre"].toString()),
              subtitle: Text(
                "${comunidad["juego"].toString()} • ${comunidad["seguidores"].toString()} seguidores",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Seguiste la comunidad")),
                  );
                },
              ),
              onTap: () {
                // Aquí puedes abrir una nueva vista si lo deseas
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Crear nueva comunidad")),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Crear comunidad"),
        backgroundColor: Colors.black,
      ),
>>>>>>> bebbbff (Progreso actual de registro y validaciones)
    );
  }
}
