import 'package:flutter/material.dart';
import '../../Equipo/crear_equipo_page.dart';
import '../widgets/Tags_page.dart';
import '../widgets/Torneo/TorneosSection.dart';


class InicioPage extends StatelessWidget {
  const InicioPage({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    final tieneEquipo = true;
    final comunidades = ['Mobile Legends', 'League of Legends'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── SECCIÓN DE EQUIPO ─────────────────────────────
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!tieneEquipo)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          "No tienes equipo",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
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
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Acción para unirse a equipo
                            },
                            icon: const Icon(Icons.group_add),
                            label: const Text("Unirse a equipo"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ─── TORNEOS ──────────────────────────────────────
              const TorneosSection(),// De aqui se llaman los torneos disponibles
             

              // ─── TAGS ─────────────────────────────────────────
              const Text(
                "Explorar por Tags",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: tagList
                    .map(
                      (tag) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => tag.page),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: tag.color.withOpacity(0.05),
                            border: Border.all(color: tag.color, width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: tag.color.withOpacity(0.2),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Text(
                            tag.label,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: tag.color,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              // ─── COMUNIDADES ──────────────────────────────────
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
                  onTap: () {
                    // Acción para abrir comunidad
                  },
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
