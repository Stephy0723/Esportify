import 'package:flutter/material.dart';

class ProfilePreviewCard extends StatelessWidget {
  final String username;
  final String realName;
  final String rank;
  final String game;
  final String team;
  final String imagePath;
  final VoidCallback onTap;

  const ProfilePreviewCard({
    super.key,
    required this.username,
    required this.realName,
    required this.rank,
    required this.game,
    required this.team,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1F),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 38, backgroundImage: AssetImage(imagePath)),
          const SizedBox(height: 12),
          Text(
            username,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            realName,
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              rank,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    "Juego principal",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    game,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Equipo actual",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    team,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[850],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Ver perfil",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
