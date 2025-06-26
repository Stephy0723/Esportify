import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../widgets/custom_navbar.dart';
import 'inicio_page.dart';
import 'comunidad_page.dart';
import 'torneos_page.dart';
import 'clases_pro_page.dart';
import 'perfil_page.dart';
import 'chat_general_page.dart';

import '../widgets/TopIconsBar.dart';
import '../widgets/NotificationsDialog.dart';
import '../widgets/SearchDialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final _pages = [
    const InicioPage(),
    const ComunidadPage(),
    const TorneosPage(),
    const ClasesProPage(),
    const PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navBarHeight = kBottomNavigationBarHeight + 16.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TopIconsBar(
                onUserTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuario tocado')),
                  );
                },
                onNotificationsTap: () => NotificationsDialog.show(context),
                onSearchTap: () => SearchDialog.show(context),
              ),
            ),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomNavBar(
          selectedIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 16, bottom: navBarHeight),
        child: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          activeBackgroundColor: Colors.white,
          activeForegroundColor: Colors.black87,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.chat_bubble_outline),
              label: 'Mensajes',
              labelStyle: const TextStyle(fontSize: 14),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatGeneralPage()),
              ),
            ),
            SpeedDialChild(
              child: const Icon(Icons.auto_awesome),
              label: 'Asistente IA',
              labelStyle: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
