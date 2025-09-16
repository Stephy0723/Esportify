import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EncabezadoConfig extends StatelessWidget {
  final String username;
  final String userId;
  final String estado;
  final String userTag;
  final String imagePath;
  final VoidCallback onEditar;

  const EncabezadoConfig({
    super.key,
    required this.username,
    this.userId = '#000123',
    this.estado = 'offline',
    this.userTag = '@usuario123',
    this.imagePath = 'assets/avatar.png', // coloca tu imagen aquí
    required this.onEditar,
  });

  Color _estadoColor(String estado) {
    switch (estado.toLowerCase()) {
      case 'online':
        return Colors.greenAccent;
      case 'tournament':
        return Colors.orange;
      case 'offline':
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(radius: 32, backgroundImage: AssetImage(imagePath)),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre y estado
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          estado,
                          style: TextStyle(
                            color: _estadoColor(estado),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _estadoColor(estado),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Usuario tag
                Text(
                  userTag,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 2),
                // ID + botón copiar
                Row(
                  children: [
                    Text(
                      'ID: $userId',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: userId));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ID copiado')),
                        );
                      },
                      child: const Icon(
                        Icons.copy,
                        size: 16,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Botón editar perfil
                ElevatedButton(
                  onPressed: onEditar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[600],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Editar perfil'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
