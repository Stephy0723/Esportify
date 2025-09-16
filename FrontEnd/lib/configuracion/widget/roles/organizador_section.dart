import 'package:flutter/material.dart';
import '../../section_box.dart';

class OrganizadorSection extends StatelessWidget {
  const OrganizadorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return styledBox('🏟 Torneos organizados', [
      'Copa Rayo 2025',
      'Valorant Elite',
    ]);
  }
}
