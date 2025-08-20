import 'package:flutter/material.dart';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({super.key});

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  final String username = 'Celestial22';
  final String userId = '#000123';
  final String estado =
      'offline'; // puedes cambiar entre: offline, online, tournament

  Map<String, bool> rolesActivos = {
    'Jugador': true,
    'Coach': false,
    'Organizador': false,
    'Creador de contenido': false,
  };

  void _solicitarRol(String rol) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Solicitar acceso como $rol',
          style: const TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Para activar este rol necesitas llenar un formulario de verificación.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                rolesActivos[rol] = true;
              });
              Navigator.pop(context);
            },
            child: const Text('Activar temporalmente'),
          ),
        ],
      ),
    );
  }

  Widget _buildEncabezado() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF1A1A1A),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(
              'assets/avatar.jpg',
            ), // asegúrate de tener esta imagen
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      userId,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Acción de copiar
                      },
                      child: const Icon(
                        Icons.copy,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(estado, style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 4),
              const Icon(Icons.circle, size: 10, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: rolesActivos.entries.map((entry) {
          final rol = entry.key;
          final activo = entry.value;

          return ElevatedButton.icon(
            onPressed: () {
              if (!activo && rol != 'Jugador') {
                _solicitarRol(rol);
              }
            },
            icon: const Icon(Icons.check, size: 16),
            label: Text(
              rol,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: activo ? Colors.deepPurple : Colors.grey[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          _buildEncabezado(),
          _buildRoles(),
          const SizedBox(height: 20),
          // Aquí puedes insertar más widgets como secciones personalizadas
        ],
      ),
    );
  }
}
