import 'package:flutter/material.dart';

// Importa la página principal de comunidad si la necesitas para otro uso (sin alias)
// import 'comunidad_page.dart';

// Importa la página específica Mobile Legends con alias para evitar conflicto
import 'juegos/mlbb_community_page.dart' as mlbb_page;

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  void _goToComunidad(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const mlbb_page.MlbbCommunityPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Inicio'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _goToComunidad(context),
          child: const Text('Ir a Comunidad Mobile Legends'),
        ),
      ),
    );
  }
}
