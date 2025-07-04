// ... importaciones
import 'package:flutter/material.dart';
import '../verificacion/verificacion_jugador.dart';
import '../verificacion/verificacion_coach.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';

class MobaForm extends StatefulWidget {
  const MobaForm({super.key});

  @override
  State<MobaForm> createState() => _MobaFormState();
}

class _MobaFormState extends State<MobaForm> {
  String? juegoSeleccionado;
  File? logoEquipo;
  String qrData = '';

  final List<String> juegosMOBA = [
    'Mobile Legends',
    'League of Legends',
    'Wild Rift',
    'Arena of Valor',
    'Pokémon Unite',
  ];

  Map<String, bool> verificados = {
    "EXP": false,
    "Gold": false,
    "Mid": false,
    "Jungla": false,
    "Roam": false,
    "Suplente 1": false,
    "Suplente 2": false,
    "Coach": false,
  };

  bool get equipoVerificado => verificados.values.every((v) => v == true);

  void verificar(String key) {
    setState(() => verificados[key] = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$key verificado correctamente'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => logoEquipo = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              equipoVerificado ? "✅ Equipo Verificado" : "Crear equipo MOBA",
              style: TextStyle(
                color: equipoVerificado ? Colors.green : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 25),
          _buildDropdown(),
          const SizedBox(height: 25),
          _buildLogo(),
          const SizedBox(height: 25),
          _buildSlogan(),
          const SizedBox(height: 30),
          _buildRoles("Titulares", ["EXP", "Gold", "Mid", "Jungla", "Roam"]),
          const SizedBox(height: 20),
          _buildRoles("Suplentes", ["Suplente 1", "Suplente 2"]),
          const SizedBox(height: 20),
          _buildRoles("Coach", ["Coach"], isCoach: true),
          const SizedBox(height: 30),
          if (qrData.isNotEmpty)
            Center(
              child: QrImageView(
                data: qrData,
                size: 150,
                backgroundColor: Colors.white,
              ),
            ),
          const SizedBox(height: 20),
          _buildGuardarQRButton(),
          const SizedBox(height: 30),
          _buildOpcionesInvitacion(), // <<<<< ESTA ES LA SECCIÓN FINAL QUE PEDISTE
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Selecciona el juego:",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<String>(
            value: juegoSeleccionado,
            dropdownColor: Colors.grey[900],
            iconEnabledColor: Colors.white,
            decoration: const InputDecoration(border: InputBorder.none),
            style: const TextStyle(color: Colors.white),
            items: juegosMOBA
                .map(
                  (juego) => DropdownMenuItem(value: juego, child: Text(juego)),
                )
                .toList(),
            onChanged: (val) => setState(() => juegoSeleccionado = val),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Logo del equipo:", style: TextStyle(color: Colors.white70)),
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

  Widget _buildSlogan() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Eslogan del equipo',
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

  Widget _buildRoles(
    String titulo,
    List<String> roles, {
    bool isCoach = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: roles.map((rol) {
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
                    backgroundColor: verificado
                        ? Colors.green
                        : Colors.grey[800],
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
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGuardarQRButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Aquí podrías guardar la información del equipo si usas base de datos
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Equipo guardado correctamente"),
              backgroundColor: Colors.green,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text("Guardar equipo"),
      ),
    );
  }

  Widget _buildOpcionesInvitacion() {
    return Column(
      children: [
        const Divider(height: 40, color: Colors.white24),
        _buildOpcionInvitacion(Icons.share, "Enviar invitación por enlace", () {
          // Acción de compartir enlace
        }),
        const SizedBox(height: 10),
        _buildOpcionInvitacion(
          Icons.qr_code,
          "Enviar invitación por código QR",
          () {
            // Acción de mostrar QR
          },
        ),
        const SizedBox(height: 10),
        _buildOpcionInvitacion(Icons.search, "Buscar por nombre", () {
          // Acción de búsqueda
        }),
      ],
    );
  }

  Widget _buildOpcionInvitacion(
    IconData icon,
    String texto,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 12),
            Text(texto, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
