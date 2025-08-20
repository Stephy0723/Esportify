import 'package:flutter/material.dart';

class ValorantCommunityPage extends StatelessWidget {
  const ValorantCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Valorant'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Bienvenido a la comunidad de Valorant',
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
