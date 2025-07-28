import 'package:flutter/material.dart';

class JuegosPorTagPage extends StatelessWidget {
  final String tag;

  const JuegosPorTagPage({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juegos para $tag'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Aquí irán los juegos para $tag',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
