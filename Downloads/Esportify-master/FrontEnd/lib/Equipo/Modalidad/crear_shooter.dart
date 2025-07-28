import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../verificacion/verificacion_jugador.dart';
import '../verificacion/verificacion_coach.dart';

class ShooterForm extends StatefulWidget {
  const ShooterForm({super.key});

  @override
  State<ShooterForm> createState() => _ShooterFormState();
}

class _ShooterFormState extends State<ShooterForm> {
  final _nombreCtrl = TextEditingController();
  String? _juegoSeleccionado = 'Call of Duty'; // Valor inicial
  File? _logo;

  final juegosShooter = [
    'Call of Duty',
    'Valorant',
    'Apex Legends',
    'Rainbow Six Siege',
    'Counter Strike 2',
  ];

  final Map<String, bool> verificados = {};
  List<String> titulares = [];
  List<String> suplentes = [];
  bool mostrarCoach = true;

  void _verificar(String rol) {
    setState(() => verificados[rol] = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$rol verificado'), backgroundColor: Colors.green),
    );
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _logo = File(picked.path));
  }

  void _actualizarJugadores() {
    verificados.clear();
    titulares.clear();
    suplentes.clear();

    switch (_juegoSeleccionado) {
      case 'Call of Duty':
        titulares.addAll(['Jugador 1', 'Jugador 2', 'Jugador 3', 'Jugador 4']);
        suplentes.addAll(['Suplente 1']);
        mostrarCoach = true;
        break;
      case 'Valorant':
        titulares.addAll([
          'Jugador 1',
          'Jugador 2',
          'Jugador 3',
          'Jugador 4',
          'Jugador 5',
        ]);
        suplentes.addAll(['Suplente 1', 'Suplente 2']);
        mostrarCoach = true;
        break;
      case 'Apex Legends':
        titulares.addAll(['Jugador 1', 'Jugador 2', 'Jugador 3']);
        suplentes.clear();
        mostrarCoach = false;
        break;
      case 'Rainbow Six Siege':
        titulares.addAll([
          'Jugador 1',
          'Jugador 2',
          'Jugador 3',
          'Jugador 4',
          'Jugador 5',
        ]);
        suplentes.addAll(['Suplente 1']);
        mostrarCoach = true;
        break;
      case 'Counter Strike 2':
        titulares.addAll([
          'Jugador 1',
          'Jugador 2',
          'Jugador 3',
          'Jugador 4',
          'Jugador 5',
        ]);
        suplentes.clear();
        mostrarCoach = false;
        break;
      default:
        break;
    }

    for (var j in [...titulares, ...suplentes]) {
      verificados[j] = false;
    }
    if (mostrarCoach) verificados['Coach'] = false;
  }

  bool get equipoListo {
    return titulares.every((j) => verificados[j] == true) &&
        (!mostrarCoach || verificados['Coach'] == true);
  }

  @override
  void initState() {
    super.initState();
    _actualizarJugadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selecciona una modalidad:",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            _buildDropdown(juegosShooter, _juegoSeleccionado, (val) {
              setState(() {
                _juegoSeleccionado = val;
                _actualizarJugadores();
              });
            }),
            const SizedBox(height: 20),
            Center(
              child: Text(
                equipoListo ? "✅ Equipo listo" : "Crear equipo Shooter",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSubtitulo("Selecciona el juego"),
            _buildDropdown(juegosShooter, _juegoSeleccionado, (val) {
              setState(() {
                _juegoSeleccionado = val;
                _actualizarJugadores();
              });
            }),
            const SizedBox(height: 12),
            _buildTextInput("Nombre del equipo", _nombreCtrl),
            const SizedBox(height: 20),

            if (titulares.isNotEmpty)
              _buildJugadorIcons("Jugadores", titulares),
            if (suplentes.isNotEmpty)
              _buildJugadorIcons("Suplentes", suplentes),
            if (mostrarCoach) _buildJugadorIcons("Coach", ["Coach"]),

            const SizedBox(height: 30),
            _buildBotonesInvitacion(),
            const SizedBox(height: 30),
            _buildBotonGuardar(),
          ],
        ),
      ),
    );
  }

  Widget _buildJugadorIcons(String titulo, List<String> jugadores) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubtitulo(titulo),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: jugadores
              .map(
                (j) => GestureDetector(
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
                        backgroundColor: (verificados[j] ?? false)
                            ? Colors.green
                            : Colors.grey[700],
                        child: Icon(
                          (verificados[j] ?? false)
                              ? Icons.verified
                              : Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        j,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
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

  Widget _buildDropdown(
    List<String> items,
    String? selected,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        value: selected,
        iconEnabledColor: Colors.white,
        dropdownColor: Colors.grey[900],
        decoration: const InputDecoration(border: InputBorder.none),
        style: const TextStyle(color: Colors.white),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSubtitulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
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

  Widget _buildBotonGuardar() {
    return Center(
      child: ElevatedButton(
        onPressed: equipoListo
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Equipo guardado correctamente"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: equipoListo ? Colors.white : Colors.grey[700],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Guardar equipo",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
