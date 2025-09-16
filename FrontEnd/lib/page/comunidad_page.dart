import 'package:flutter/material.dart';

class ComunidadPage extends StatelessWidget {
  const ComunidadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> comunidades = [
      {
        "nombre": "Mobile Legends DR",
        "juego": "Mobile Legends",
        "seguidores": 1200,
      },
      {"nombre": "Valorant Elite", "juego": "Valorant", "seguidores": 950},
      {
        "nombre": "League Latam",
        "juego": "League of Legends",
        "seguidores": 1430,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Comunidades"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: comunidades.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final comunidad = comunidades[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.videogame_asset, color: Colors.white),
              ),
              title: Text(comunidad["nombre"].toString()),
              subtitle: Text(
                "${comunidad["juego"].toString()} • ${comunidad["seguidores"].toString()} seguidores",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Seguiste la comunidad")),
                  );
                },
              ),
              onTap: () {
                // Aquí puedes abrir una nueva vista si lo deseas
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Crear nueva comunidad")),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Crear comunidad"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
