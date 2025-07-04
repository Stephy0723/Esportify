import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EstrategiaForm extends StatefulWidget {
  const EstrategiaForm({super.key});

  @override
  State<EstrategiaForm> createState() => _EstrategiaFormState();
}

class _EstrategiaFormState extends State<EstrategiaForm> {
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _esloganCtrl = TextEditingController();
  String? _juegoSeleccionado;
  String? _modoSeleccionado;
  File? _logo;
  final Map<String, List<String>> juegosConModos = {
    'Teamfight Tactics': ['Solitario', 'Dúo'],
    'StarCraft II': ['Solitario'],
    'Clash Royale': ['Solitario', 'Dúo'],
    'Age of Empires IV': ['Dúo', 'Cuarteto'],
    'Dota 2 Auto Chess': ['Solitario'],
  };

  List<String> jugadores = [];
  bool mostrarCoach = true;
  final Map<String, bool> verificados = {};

  void _actualizarJugadores() {
    jugadores.clear();
    verificados.clear();

    switch (_modoSeleccionado) {
      case 'Solitario':
        jugadores.add('Jugador Único');
        break;
      case 'Dúo':
        jugadores.addAll(['Jugador 1', 'Jugador 2']);
        break;
      case 'Cuarteto':
        jugadores.addAll(['Jugador 1', 'Jugador 2', 'Jugador 3', 'Jugador 4']);
        break;
    }

    for (var j in jugadores) {
      verificados[j] = false;
    }

    if (mostrarCoach) verificados['Coach'] = false;
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _logo = File(picked.path));
    }
  }

  bool get equipoListo {
    return jugadores.every((j) => verificados[j] == true) &&
        (!mostrarCoach || verificados['Coach'] == true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "¿Equipo o jugador solitario?",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.grey[900],
                value: _juegoSeleccionado,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: juegosConModos.keys
                    .map((j) => DropdownMenuItem(value: j, child: Text(j)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _juegoSeleccionado = val;
                    _modoSeleccionado = null;
                  });
                },
              ),
              const SizedBox(height: 10),
              if (_juegoSeleccionado != null)
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.grey[900],
                  value: _modoSeleccionado,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: juegosConModos[_juegoSeleccionado]!
                      .map(
                        (modo) =>
                            DropdownMenuItem(value: modo, child: Text(modo)),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _modoSeleccionado = val;
                      _actualizarJugadores();
                    });
                  },
                ),
              const SizedBox(height: 20),
              Center(child: _buildLogoSelector()),
              const SizedBox(height: 20),
              _buildTextField("Nombre del equipo", _nombreCtrl),
              const SizedBox(height: 10),
              _buildTextField("Eslogan", _esloganCtrl),
              const SizedBox(height: 20),
              if (jugadores.isNotEmpty) _buildJugadores("Jugadores", jugadores),
              if (mostrarCoach) _buildJugadores("Coach", ["Coach"]),
              const SizedBox(height: 20),
              _buildGuardarBoton(),
              const SizedBox(height: 20),
              _buildBotonesInvitacion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
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
            child: _logo == null
                ? const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 28,
                  )
                : ClipOval(
                    child: Image.file(
                      _logo!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          if (_logo == null)
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.add, size: 16, color: Colors.white),
            ),
        ],
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
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: lista.map((j) {
            return GestureDetector(
              onTap: () => _verificar(j),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: verificados[j]!
                        ? Colors.green
                        : Colors.grey[700],
                    child: Icon(
                      verificados[j]! ? Icons.verified : Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(j, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGuardarBoton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: equipoListo ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: equipoListo ? Colors.white : Colors.grey[800],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Guardar equipo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBotonesInvitacion() {
    return Column(
      children: [
        _botonInv("Enviar invitación por enlace", Icons.share),
        const SizedBox(height: 10),
        _botonInv("Enviar invitación por código QR", Icons.qr_code),
        const SizedBox(height: 10),
        _botonInv("Buscar por nombre", Icons.search),
      ],
    );
  }

  Widget _botonInv(String texto, IconData icono) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
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
