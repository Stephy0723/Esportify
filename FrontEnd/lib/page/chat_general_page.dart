// lib/page/chat_general_page.dart
import 'package:flutter/material.dart';
import 'home_page.dart';

class ChatGeneralPage extends StatelessWidget {
  const ChatGeneralPage({super.key});

  // Ejemplo de datos
  List<_ChatItem> get _chats => const [
    _ChatItem(
      name: 'Comunidad Valorant',
      lastMessage: '¡Mañana hay torneo!',
      time: '08:10',
      unreadCount: 3,
      isCommunity: true,
      color: Color(0xFF9B51E0),
    ),
    _ChatItem(
      name: 'Equipo Rocket',
      lastMessage: '¿Listos para el scrim?',
      time: '12:35',
      unreadCount: 0,
      isCommunity: true,
      color: Color(0xFF27AE60),
    ),
    _ChatItem(
      name: 'Juan Pérez',
      lastMessage: '¡Nos vemos a las 6!',
      time: '11:22',
      unreadCount: 1,
    ),
    _ChatItem(
      name: 'María López',
      lastMessage: 'Gracias por la ayuda :)',
      time: '09:15',
      unreadCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Altura del status bar
    final topInset = MediaQuery.of(context).padding.top;
    const headerHeight = 60.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Lista de chats
          Positioned.fill(
            top: topInset + headerHeight,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _chats.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => ChatTile(chat: _chats[index]),
            ),
          ),

          // Header blanco con botones
          Positioned(
            top: topInset,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón volver a home
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    ),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.home, color: Colors.black54),
                    ),
                  ),

                  const Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Botón Asistente IA
                  GestureDetector(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final _ChatItem chat;
  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    // Colores pastel suaves para comunidad
    final start = chat.color?.withOpacity(0.2) ?? Colors.transparent;
    final end = chat.color?.withOpacity(0.05) ?? Colors.transparent;

    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: chat.isCommunity ? null : Colors.grey.shade100,
          gradient: chat.isCommunity
              ? LinearGradient(
                  colors: [start, end],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: chat.isCommunity ? start : Colors.grey.shade300,
            child: Text(
              chat.name[0],
              style: const TextStyle(color: Colors.black87),
            ),
          ),
          title: Text(
            chat.name,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            chat.lastMessage,
            style: TextStyle(color: Colors.black54.withOpacity(0.8)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chat.time,
                style: TextStyle(
                  color: Colors.black54.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              if (chat.unreadCount > 0) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${chat.unreadCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ],
          ),
          onTap: () {
            // Navegar a conversación individual
          },
        ),
      ),
    );
  }
}

class _ChatItem {
  final String name, lastMessage, time;
  final int unreadCount;
  final bool isCommunity;
  final Color? color;

  const _ChatItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    this.isCommunity = false,
    this.color,
  });
}
