import 'package:flutter/material.dart';
import '../widgets/tags/tag_5vs5_page.dart';
import '../widgets/tags/tag_riot_game_page.dart';
import '../widgets/tags/tag_moba_page.dart';
import '../widgets/tags/tag_competitivo_page.dart';
import '../widgets/tags/tag_multijugador_page.dart';
import '../widgets/tags/tag_estrategia_page.dart';
import '../widgets/tags/tag_mlbb_page.dart';
import '../widgets/tags/tag_honor_of_king_page.dart';
import '../widgets/tags/tag_timi_page.dart';

class TagItem {
  final String label;
  final Color color;
  final Widget page;

  TagItem({required this.label, required this.color, required this.page});
}

final List<TagItem> tagList = [
  TagItem(label: '#5vs5', color: Colors.blue, page: const Tag5vs5Page()),
  TagItem(label: '#RiotGame', color: Colors.red, page: const TagRiotGamePage()),
  TagItem(label: '#Moba', color: Colors.green, page: const TagMobaPage()),
  TagItem(
    label: '#Competitivo',
    color: Colors.purple,
    page: const TagCompetitivoPage(),
  ),
  TagItem(
    label: '#Multijugador',
    color: Colors.orange,
    page: const TagMultijugadorPage(),
  ),
  TagItem(
    label: '#Estrategia',
    color: Colors.teal,
    page: const TagEstrategiaPage(),
  ),
  TagItem(label: '#MLBB', color: Colors.pink, page: const TagMlbbPage()),
  TagItem(
    label: '#HonorOfKing',
    color: Colors.deepPurple,
    page: const TagHonorOfKingPage(),
  ),
  TagItem(label: '#TIMI', color: Colors.cyan, page: const TagTimiPage()),
];
