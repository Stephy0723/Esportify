// lib/widgets/custom_navbar.dart
import 'package:flutter/material.dart';

/// Modelo de cada opción del navbar
class _NavItem {
  final IconData icon;
  final String label;
  final Color color;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.color,
  });
}

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  // Lista constante de items, perfil reemplazado por ajustes
  static const List<_NavItem> _items = <_NavItem>[
    _NavItem(
      icon: Icons.home_outlined,
      label: 'Inicio',
      color: Colors.blueAccent,
    ),
    _NavItem(
      icon: Icons.sports_esports_outlined,
      label: 'Comunidad',
      color: Colors.purpleAccent,
    ),
    _NavItem(
      icon: Icons.live_tv_outlined, // Transmisión
      label: 'Transmisión',
      color: Colors.cyanAccent,
    ),
    _NavItem(
      icon: Icons.settings_outlined,
      label: 'Ajustes',
      color: Colors.pinkAccent,
    ),
  ];

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 70;

    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final active = (i == selectedIndex);

          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(
                horizontal: active ? 16 : 8,
                vertical: active ? 8 : 0,
              ),
              decoration: active
                  ? BoxDecoration(
                      color: item.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    )
                  : null,
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    size: active ? 28 : 24,
                    color: active ? item.color : Colors.grey,
                  ),
                  if (active) ...[
                    const SizedBox(width: 6),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: item.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
