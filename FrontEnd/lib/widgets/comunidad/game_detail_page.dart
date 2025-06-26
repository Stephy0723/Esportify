// lib/page/game_detail_page.dart

import 'package:flutter/material.dart';
import 'package:esportefy/widgets/comunidad/game_detail_content.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo; sustituye por tu modelo real
    const demo = {
      'title': '2018',
      'tagline': 'Everyone is a Hero',
      'releaseYear': '2018',
      'tags': ['MMORPG', 'Open World', 'Fantasy'],
      'rating': 9.2,
      'votes': '570.8 k votos',
      'image': 'assets/comunidad/comunidad.mlbb.jpg',
    };

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Solo el botón de volver atrás:
        leading: const BackButton(color: Colors.white),
      ),
      body: GameDetailContent(
        title: demo['title']! as String,
        tagline: demo['tagline']! as String,
        releaseYear: demo['releaseYear']! as String,
        tags: List<String>.from(demo['tags']! as List),
        rating: demo['rating']! as double,
        votes: demo['votes']! as String,
        imageAsset: demo['image']! as String,
      ),
    );
  }
}
