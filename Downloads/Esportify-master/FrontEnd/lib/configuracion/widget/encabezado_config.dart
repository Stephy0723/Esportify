import 'package:flutter/material.dart';

class EncabezadoConfig extends StatefulWidget {
  const EncabezadoConfig({super.key});

  @override
  State<EncabezadoConfig> createState() => _EncabezadoConfigState();
}

class _EncabezadoConfigState extends State<EncabezadoConfig> {
  String estado = "En línea";
  Color estadoColor = Colors.green;
  String rolPrincipal = "Jugador";

  void _mostrarRoles() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Selecciona tus roles",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRolItem(
                Icons.sports_esports,
                "Jugador",
                true,
                isPrincipal: true,
              ),
              _buildRolItem(Icons.school, "Coach", false),
              _buildRolItem(Icons.mic, "Caster", false),
              _buildRolItem(Icons.videocam, "Streamer", false),
              _buildRolItem(Icons.analytics, "Analista", false),
              _buildRolItem(Icons.emoji_events, "Organizador", true),
              _buildRolItem(Icons.business_center, "Manager", false),
              _buildRolItem(Icons.camera_alt, "Creador de contenido", false),
              _buildRolItem(Icons.shield, "Moderador", false),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRolItem(
    IconData icon,
    String rol,
    bool activo, {
    bool isPrincipal = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(rol, style: const TextStyle(fontSize: 16)),
      trailing: activo
          ? isPrincipal
                ? const Text(
                    "✅ Principal",
                    style: TextStyle(color: Colors.green),
                  )
                : const Text("✅", style: TextStyle(color: Colors.grey))
          : TextButton(
              onPressed: () {
                // Acción para activar el rol
              },
              child: const Text("Activar"),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Espacio reservado para avatar sin imagen
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: const Icon(Icons.person_outline, size: 40, color: Colors.grey),
        ),

        const SizedBox(height: 10),
        const Text(
          "Arya Muller",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "@Mully",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),

        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              estado.toLowerCase(),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 4),
            CircleAvatar(radius: 5, backgroundColor: estadoColor),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _mostrarRoles,
              child: Row(
                children: [
                  Text(
                    rolPrincipal.toLowerCase(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            // Acción de configuración
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 1,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("⚙️ Configurar perfil"),
          ),
        ),
      ],
    );
  }
}
