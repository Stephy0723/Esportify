import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../verificacion/verificacion_jugador.dart';

class FightingForm extends StatefulWidget {
  const FightingForm({super.key});

  @override
  State<FightingForm> createState() => _FightingFormState();
}

class _FightingFormState extends State<FightingForm> {
  String? tipoEquipo;
  String? juegoSeleccionado;
  File? logoEquipo;
  bool equipoCreado = false;

  final nombreCtrl = TextEditingController();
  final sloganCtrl = TextEditingController();

  final List<String> formatos = ['Solitario', 'Dúo', 'Trío'];
  final List<String> juegosFighting = [
    'Street Fighter VI',
    'Mortal Kombat 11',
    'Tekken 8',
    'Super Smash Bros Ultimate',
    'Guilty Gear Strive',
  ];

  Map<String, bool> verificados = {
    "Jugador 1": false,
    "Jugador 2": false,
    "Jugador 3": false,
  };

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => logoEquipo = File(picked.path));
  }

  List<String> obtenerJugadores() {
    switch (tipoEquipo) {
      case 'Solitario':
        return ['Jugador 1'];
      case 'Dúo':
        return ['Jugador 1', 'Jugador 2'];
      case 'Trío':
        return ['Jugador 1', 'Jugador 2', 'Jugador 3'];
      default:
        return [];
    }
  }

  bool get equipoVerificado {
    final jugadores = obtenerJugadores();
    for (var jugador in jugadores) {
      if (!verificados[jugador]!) return false;
    }
    return true;
  }

  void verificar(String key) {
    setState(() => verificados[key] = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$key verificado'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jugadores = obtenerJugadores();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titulo(),
            const SizedBox(height: 25),

            _buildLogo(),
            const SizedBox(height: 20),

            _buildDropdown("¿Qué tipo de equipo es?", formatos, (val) {
              setState(() => tipoEquipo = val);
            }, tipoEquipo),

            const SizedBox(height: 15),

            _buildDropdown("¿Para qué juego es el equipo?", juegosFighting, (
              val,
            ) {
              setState(() => juegoSeleccionado = val);
            }, juegoSeleccionado),

            const SizedBox(height: 20),
            _buildTextInput("Nombre del equipo", nombreCtrl),
            const SizedBox(height: 10),
            _buildTextInput("Eslogan o frase", sloganCtrl),

            const SizedBox(height: 30),
            Text("Jugadores", style: _seccionStyle()),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: jugadores.map((j) => _buildAvatar(j)).toList(),
            ),

            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: equipoVerificado && !equipoCreado
                    ? () {
                        setState(() {
                          equipoCreado = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Equipo guardado correctamente"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: equipoVerificado && !equipoCreado
                      ? Colors.white
                      : Colors.grey[800],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.white24),
                  ),
                  elevation: equipoVerificado ? 6 : 0,
                ),
                child: const Text(
                  "Crear equipo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _titulo() {
    return Center(
      child: Text(
        equipoCreado ? "✅ Equipo Listo" : "Crear equipo Fighting",
        style: TextStyle(
          color: equipoCreado ? Colors.green : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    Function(String?) onChanged,
    String? value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<String>(
            value: value,
            dropdownColor: Colors.grey[900],
            iconEnabledColor: Colors.white,
            decoration: const InputDecoration(border: InputBorder.none),
            style: const TextStyle(color: Colors.white),
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildTextInput(String hint, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Logo del equipo (opcional)",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 10),
        Center(
          child: GestureDetector(
            onTap: pickImage,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[850],
              backgroundImage: logoEquipo != null
                  ? FileImage(logoEquipo!)
                  : null,
              child: logoEquipo == null
                  ? const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.white60,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String rol) {
    final verificado = verificados[rol] ?? false;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const VerificacionJugadorForm(),
              ),
            );
            verificar(rol);
          },
          child: CircleAvatar(
            backgroundColor: verificado ? Colors.green : Colors.grey[800],
            radius: 26,
            child: Icon(
              verificado ? Icons.verified : Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            rol,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ),
      ],
    );
  }

  TextStyle _seccionStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}
