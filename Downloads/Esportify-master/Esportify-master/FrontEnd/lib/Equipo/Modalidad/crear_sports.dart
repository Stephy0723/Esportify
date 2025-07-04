import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../verificacion/verificacion_jugador.dart';
import '../verificacion/verificacion_coach.dart';

class SportForm extends StatefulWidget {
  const SportForm({super.key});

  @override
  State<SportForm> createState() => _SportFormState();
}

class _SportFormState extends State<SportForm> {
  String? _juegoSeleccionado = 'FIFA';
  final _nombreCtrl = TextEditingController();
  final _esloganCtrl = TextEditingController();
  File? _logo;

  List<String> jugadores = [];
  bool mostrarCoach = true;
  final Map<String, bool> verificados = {};

  final Map<String, String> tipoJuego = {
    'FIFA': 'Dúo',
    'eFootball': 'Dúo',
    'NBA 2K': 'Cuarteto',
    'Madden NFL': 'Trío',
    'MLB The Show': 'Solitario',
  };

  @override
  void initState() {
    super.initState();
    _actualizarJugadores();
  }

  void _actualizarJugadores() {
    jugadores.clear();
    verificados.clear();

    switch (_juegoSeleccionado) {
      case 'FIFA':
      case 'eFootball':
        jugadores.addAll(['Jugador 1', 'Jugador 2']);
        mostrarCoach = true;
        break;
      case 'NBA 2K':
        jugadores.addAll(['Jugador 1', 'Jugador 2', 'Jugador 3', 'Jugador 4']);
        mostrarCoach = true;
        break;
      case 'Madden NFL':
        jugadores.addAll(['Jugador 1', 'Jugador 2', 'Jugador 3']);
        mostrarCoach = true;
        break;
      case 'MLB The Show':
        jugadores.addAll(['Jugador Único']);
        mostrarCoach = false;
        break;
    }

    for (var j in jugadores) {
      verificados[j] = false;
    }
    if (mostrarCoach) {
      verificados['Coach'] = false;
    }
  }

  void _verificar(String nombre) {
    setState(() => verificados[nombre] = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$nombre verificado'),
        backgroundColor: Colors.green,
      ),
    );
  }

  bool get equipoListo {
    return jugadores.every((j) => verificados[j] == true) &&
        (!mostrarCoach || verificados['Coach'] == true);
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _logo = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBotonGuardar(),
                    const SizedBox(height: 20),
                    _buildDropdown(),
                    const SizedBox(height: 20),
                    Center(child: _buildLogoSelector()),
                    const SizedBox(height: 20),
                    _buildTextInput("Nombre del equipo", _nombreCtrl),
                    const SizedBox(height: 10),
                    _buildTextInput("Eslogan", _esloganCtrl),
                    const SizedBox(height: 30),
                    if (jugadores.isNotEmpty)
                      _buildJugadores("Jugadores", jugadores),
                    if (mostrarCoach) _buildJugadores("Coach", ["Coach"]),
                    const SizedBox(height: 30),
                    _buildBotonesInvitacion(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBotonGuardar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: equipoListo
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Equipo deportivo guardado"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: equipoListo ? Colors.white : Colors.grey[700],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Guardar equipo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Juego",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<String>(
            value: _juegoSeleccionado,
            iconEnabledColor: Colors.white,
            dropdownColor: Colors.grey[900],
            decoration: const InputDecoration(border: InputBorder.none),
            style: const TextStyle(color: Colors.white),
            items: tipoJuego.keys
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (val) {
              setState(() {
                _juegoSeleccionado = val;
                _actualizarJugadores();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSelector() {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[800],
            backgroundImage: _logo != null ? FileImage(_logo!) : null,
            child: _logo == null
                ? const Icon(Icons.image, color: Colors.white, size: 30)
                : null,
          ),
          if (_logo == null)
            const Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: Icon(Icons.add, size: 14, color: Colors.black),
              ),
            ),
        ],
      ),
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

  Widget _buildJugadores(String titulo, List<String> lista) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: lista.map((j) {
            final bool verif = verificados[j] ?? false;
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => j == "Coach"
                        ? const VerificacionCoachForm()
                        : const VerificacionJugadorForm(),
                  ),
                );
                _verificar(j);
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: verif ? Colors.green : Colors.grey[800],
                    child: Icon(
                      verif ? Icons.verified : Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    j,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBotonesInvitacion() {
    return Column(
      children: [
        _botonInv("Enviar invitación por enlace", Icons.share),
        const SizedBox(height: 8),
        _botonInv("Enviar invitación por código QR", Icons.qr_code),
        const SizedBox(height: 8),
        _botonInv("Buscar por nombre", Icons.search),
      ],
    );
  }

  Widget _botonInv(String texto, IconData icono) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icono, color: Colors.white70),
          const SizedBox(width: 12),
          Text(texto, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
