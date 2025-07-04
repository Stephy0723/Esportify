// lib/register/register_step_three.dart

import 'package:flutter/material.dart';
import 'register_step_four.dart'; // Ajusta la ruta si es necesario

class RegisterStepThree extends StatefulWidget {
  const RegisterStepThree({super.key, required this.userData});

  final Map<String, String?> userData;

  @override
  State<RegisterStepThree> createState() => _RegisterStepThreeState();
}

class _RegisterStepThreeState extends State<RegisterStepThree> {
  // -------------------- Juegos (9 items, Overwatch2 eliminado) --------------------
  final List<Map<String, String>> _games = [
    {'id': 'hok', 'asset': 'assets/registro/hok.logo.png'},
    {'id': 'lol', 'asset': 'assets/registro/lol.logo.png'},
    {'id': 'mlbb', 'asset': 'assets/registro/mlbb.logo.png'},
    {'id': 'mk', 'asset': 'assets/registro/MK.logo.png'},
    {'id': 'sf6', 'asset': 'assets/registro/sf6.logo.png'},
    {'id': 'tft', 'asset': 'assets/registro/tft.logo.png'},
    {'id': 'wildrift', 'asset': 'assets/registro/wldrft.logo.png'},
    {'id': 'marvel', 'asset': 'assets/registro/marvel.logo.png'},
    {'id': 'freefire', 'asset': 'assets/registro/Frefire.logo.png'},
  ];
  final Set<String> _selectedGames = {};

  // ------------------ Plataformas ------------------
  final List<String> _platforms = [
    'PC',
    'PlayStation',
    'Xbox',
    'Switch',
    'Móvil',
  ];
  final Set<String> _selectedPlatforms = {};

  // ------------- Juego personalizado --------------
  final TextEditingController _customGameCtrl = TextEditingController();

  void _toggleGame(String id) {
    setState(() {
      if (!_selectedGames.remove(id)) _selectedGames.add(id);
    });
  }

  void _togglePlatform(String platform) {
    setState(() {
      if (!_selectedPlatforms.remove(platform)) {
        _selectedPlatforms.add(platform);
      }
    });
  }

  void _onNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StepFour(
          userData: {
            ...widget.userData,
            'juegosFavoritos': _selectedGames.isNotEmpty
                ? _selectedGames.first
                : '',
            'plataformas': _selectedPlatforms.isNotEmpty
                ? _selectedPlatforms.first
                : '',
            'juegoPersonalizado': _customGameCtrl.text.trim(),
          },
        ),
      ),
    );
  }

  void _onBack() => Navigator.pop(context);

  @override
  void dispose() {
    _customGameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text('Preferencias de Juego'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Selecciona tus juegos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Grid de logos (3 columnas x 9 items)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _games.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (_, i) {
                  final game = _games[i];
                  final selected = _selectedGames.contains(game['id']);
                  return GestureDetector(
                    onTap: () => _toggleGame(game['id']!),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            game['asset']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        if (selected)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
              const Text(
                '¿En qué plataforma juegas?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              // Plataformas como ChoiceChips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _platforms.map((plat) {
                  final sel = _selectedPlatforms.contains(plat);
                  return ChoiceChip(
                    label: Text(plat),
                    selected: sel,
                    onSelected: (_) => _togglePlatform(plat),
                    selectedColor: Colors.black,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: sel ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
              TextField(
                controller: _customGameCtrl,
                decoration: InputDecoration(
                  hintText: '¿Tu juego no está? Escríbelo aquí',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _onBack,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Volver',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Siguiente',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
