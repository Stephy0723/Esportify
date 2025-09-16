// lib/widgets/comunidad/game_detail_content.dart

import 'package:flutter/material.dart';

class GameDetailContent extends StatelessWidget {
  const GameDetailContent({
    super.key,
    required this.title,
    required this.tagline,
    required this.releaseYear,
    required this.tags,
    required this.rating,
    required this.votes,
    required this.imageAsset,
  });

  final String title;
  final String tagline;
  final String releaseYear;
  final List<String> tags;
  final double rating;
  final String votes;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Título grande
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // 2. Subtítulo pequeño
          Text(
            tagline,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          // 3. Píldoras (año + tags)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Pill(text: releaseYear),
              for (final t in tags) _Pill(text: t),
            ],
          ),
          const SizedBox(height: 16),
          // 4. Rating + votos
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '${rating.toStringAsFixed(1)}/10',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(votes, style: const TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 24),
          // 5. Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imageAsset,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
