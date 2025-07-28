import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String nombre;
  final String juego;
  final String coach;
  final List<String> jugadores;
  final String tipo; // 'nuevo', 'femenino', 'universitario'

  const TeamCard({
    super.key,
    required this.nombre,
    required this.juego,
    required this.coach,
    required this.jugadores,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    // Mapa de tipos con sus fondos e insignias
    final fondoPorTipo = {
      'nuevo': 'lib/assets/roles/fondoNovato.png',
      'femenino': 'lib/assets/roles/fondoFem.png',
      'universitario': 'lib/assets/roles/fondoUni.png',
    };

    final insigniaPorTipo = {
      'nuevo': 'lib/assets/roles/rama.png',
      'femenino': 'lib/assets/roles/corona.png',
      'universitario': 'lib/assets/roles/birrete.png',
    };

    final fondo = fondoPorTipo[tipo] ?? fondoPorTipo['nuevo']!;
    final insignia = insigniaPorTipo[tipo] ?? insigniaPorTipo['nuevo']!;

    return Container(
      height: 220,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(fondo),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            right: 12,
            child: Image.asset(insignia, width: 40, height: 40),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  juego,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Row(
                  children: jugadores
                      .take(5)
                      .map(
                        (url) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(url),
                            radius: 18,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Coach: $coach",
                      style: const TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        debugPrint("Ver equipo: $nombre");
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      child: const Text("Ver equipo"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
