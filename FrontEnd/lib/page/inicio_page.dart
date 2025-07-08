import 'package:flutter/material.dart';
import '../../Equipo/crear_equipo_page.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tieneEquipo = true; // ← cámbialo luego por el dato real
    final nombreEquipo = "Shadow Wolves";
    final juegosFavoritos = [
      'Riot',
      'Shooter',
      'MOBA',
      'MLBB',
      'LOL',
      'Valorant',
    ];
    final comunidades = ['Mobile Legends', 'League of Legends'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de equipo
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tieneEquipo ? nombreEquipo : 'Sin equipo',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              debugPrint("CLICK EN CREAR EQUIPO");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CrearEquipoPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Crear equipo"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.group_add),
                            label: const Text("Unirse a equipo"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Torneos
              const Text(
                "Torneos disponibles",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    torneoBox("Torneo Valorant - Junio"),
                    torneoBox("MLBB Clash"),
                    torneoBox("League of Legends Global"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Juegos
              const Text(
                "Tus juegos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: juegosFavoritos
                    .map((tag) => Chip(label: Text(tag)))
                    .toList(),
              ),

              const SizedBox(height: 24),

              // Comunidades
              const Text(
                "Comunidades",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...comunidades.map(
                (comunidad) => ListTile(
                  leading: const Icon(Icons.videogame_asset),
                  title: Text(comunidad),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget torneoBox(String title) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
