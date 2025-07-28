import '../../section_box.dart';
import 'package:flutter/material.dart';

class CoachSection extends StatelessWidget {
  const CoachSection({super.key});

  @override
  Widget build(BuildContext context) {
    return styledBox('🧑‍🏫 Equipos como Coach', [
      'Storm X – Coach General',
      'Titan Force – Estrategia',
    ]);
  }
}
