import 'package:flutter/material.dart';

class TopIconsBar extends StatelessWidget {
  final VoidCallback onUserTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onSearchTap;

  const TopIconsBar({
    super.key,
    required this.onUserTap,
    required this.onNotificationsTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Usuario
        GestureDetector(
          onTap: onUserTap,
          child: const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/147/147144.png',
            ),
          ),
        ),

        // Notificaciones y búsqueda
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
              onPressed: onNotificationsTap,
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 28),
              onPressed: onSearchTap,
            ),
          ],
        ),
      ],
    );
  }
}
