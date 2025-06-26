// lib/loading/LoadingScreen.dart

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  /// Función asíncrona que se ejecutará al montar el widget.
  /// Cuando termine, debes navegar a la pantalla destino.
  final Future<void> Function() onLoadComplete;

  const LoadingScreen({super.key, required this.onLoadComplete});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Tras el primer frame, lanzamos la tarea
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.onLoadComplete();
      // Aquí puedes, por ejemplo, hacer:
      // Navigator.of(context).pushReplacement(...);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tu GIF de carga en el centro
            Image.asset(
              'assets/loanding.gif',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              'Cargando...',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
