import 'package:flutter/material.dart';
import '../../section_box.dart';

class CreadorSection extends StatelessWidget {
  const CreadorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return styledBox('📸 Contenido publicado', [
      'YouTube: Celestial Clips',
      'TikTok: @celestial22',
    ]);
  }
}
