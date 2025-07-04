import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../verificacion/verificacion_jugador.dart';
import '../verificacion/verificacion_coach.dart';

class BattleRoyaleForm extends StatefulWidget {
  const BattleRoyaleForm({super.key});

  @override
  State<BattleRoyaleForm> createState() => _BattleRoyaleFormState();
}

class _BattleRoyaleFormState extends State<BattleRoyaleForm> {
  String? juegoSeleccionado;
  String? tipoEscuadra;
  File? logoEquipo;

  final nombreCtrl = TextEditingController();
  final sloganCtrl = TextEditingController();

  final List<String> juegosBattleRoyale = [
    'Free Fire',
    'Call of Duty: Warzone',
    'Fortnite',
    'PUBG',
    'Apex Legends',
  ];

  final List<String> formatos = ['Solista', 'Dúo', 'Escuadra'];

  Map<String, bool> verificados = {
    "Jugador 1": false,
    "Jugador 2": false,
    "Jugador 3": false,
    "Jugador 4": false,
    "Coach": false,
  };

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => logoEquipo = File(picked.path));
  }

  List<String> obtenerJugadores() {
    switch (tipoEscuadra) {
      case 'Solista':
        return ['Jugador 1'];
      case 'Dúo':
        return ['Jugador 1', 'Jugador 2'];
      case 'Escuadra':
        return ['Jugador 1', 'Jugador 2', 'Jugador 3', 'Jugador 4'];
      default:
        return [];
    }
  }

  bool get equipoVerificado {
    final jugadores = obtenerJugadores();
    for (var jugador in jugadores) {
      if (!verificados[jugador]!) return false;
    }
    return verificados['Coach']!;
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
            _tituloVerificacion(),
            const SizedBox(height: 25),

            _buildDropdown(
              "Selecciona el juego",
              juegosBattleRoyale,
              (val) => setState(() => juegoSeleccionado = val),
              juegoSeleccionado,
            ),

            const SizedBox(height: 20),
            _buildLogo(),
            const SizedBox(height: 20),

            _buildDropdown(
              "¿Qué tipo de escuadra son?",
              formatos,
              (val) => setState(() => tipoEscuadra = val),
              tipoEscuadra,
            ),

            const SizedBox(height: 20),
            _buildTextInput("Nombre del equipo", nombreCtrl),
            const SizedBox(height: 10),
            _buildTextInput("Eslogan", sloganCtrl),

            const SizedBox(height: 30),
            Text("Jugadores", style: _seccionStyle()),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: jugadores.map((j) => _buildAvatar(j, false)).toList(),
            ),

            const SizedBox(height: 30),
            Text("Coach", style: _seccionStyle()),
            const SizedBox(height: 10),
            _buildAvatar("Coach", true),

            const SizedBox(height: 40),
            _buildGuardarEquipoButton(),

            const SizedBox(height: 40),
            Divider(color: Colors.white30),
            const SizedBox(height: 20),

            _buildAccionesInvitacion(
              Icons.share,
              "Enviar invitación por enlace",
            ),
            const SizedBox(height: 10),
            _buildAccionesInvitacion(
              Icons.qr_code,
              "Enviar invitación por código QR",
            ),
            const SizedBox(height: 10),
            _buildAccionesInvitacion(Icons.search, "Buscar por nombre"),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _tituloVerificacion() {
    return Center(
      child: Text(
        equipoVerificado ? "✅ Equipo Verificado" : "Crear equipo Battle Royale",
        style: TextStyle(
          color: equipoVerificado ? Colors.green : Colors.white,
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
        const Text("Logo del equipo", style: TextStyle(color: Colors.white70)),
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

  Widget _buildAvatar(String rol, bool isCoach) {
    final verificado = verificados[rol] ?? false;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => isCoach
                    ? const VerificacionCoachForm()
                    : const VerificacionJugadorForm(),
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
        const SizedBox(height: 4),
        Text(rol, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  Widget _buildAccionesInvitacion(IconData icon, String texto) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 12),
          Text(texto, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildGuardarEquipoButton() {
    return Center(
      child: ElevatedButton(
        onPressed: equipoVerificado
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("✅ Equipo guardado correctamente"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: equipoVerificado ? Colors.white : Colors.grey[800],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white24),
          ),
          elevation: equipoVerificado ? 6 : 0,
        ),
        child: const Text(
          "Guardar equipo",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
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
