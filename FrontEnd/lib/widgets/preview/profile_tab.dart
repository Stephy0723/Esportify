import 'package:flutter/material.dart';
import 'player_public_view.dart';

class ProfilePreviewScreen extends StatelessWidget {
  const ProfilePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockPlayer = {
      'name': 'José Martínez',
      'username': 'KillerPro13',
      'verified': true,
      'image': 'https://randomuser.me/api/portraits/men/32.jpg',
      'mainGame': 'Valorant',
      'role': 'Duelist',
      'games': [
        {
          'name': 'Valorant',
          'logo':
              'https://upload.wikimedia.org/wikipedia/en/9/9f/Valorant_logo_-_pink.svg',
          'role': 'Duelist',
        },
        {
          'name': 'MLBB',
          'logo':
              'https://seeklogo.com/images/M/mobile-legends-logo-B8487DD0FB-seeklogo.com.png',
          'role': 'Support',
        },
        {
          'name': 'TFT',
          'logo':
              'https://seeklogo.com/images/T/teamfight-tactics-logo-383384A0F0-seeklogo.com.png',
          'role': 'Strategist',
        },
      ],
      'tournament': 'National Tournament 2025',
      'result': 'Finalist',
      'team': 'INVINCIBLES',
      'teamRole': 'Player',
      'teamLogo':
          'https://upload.wikimedia.org/wikipedia/en/thumb/e/e7/Invincible_2021_TV_series_logo.svg/1200px-Invincible_2021_TV_series_logo.svg.png',
    };

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Public Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: PlayerPublicView(data: mockPlayer),
    );
  }
}
