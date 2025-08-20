import 'package:flutter/material.dart';

class VerificacionJugadorUniversitarioForm extends StatefulWidget {
  const VerificacionJugadorUniversitarioForm({super.key});

  @override
  State<VerificacionJugadorUniversitarioForm> createState() =>
      _VerificacionJugadorUniversitarioFormState();
}

class _VerificacionJugadorUniversitarioFormState
    extends State<VerificacionJugadorUniversitarioForm> {
  bool verificado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Verificación Universitaria",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.verified,
              color: verificado ? Colors.green : Colors.white38,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            _input(Icons.person, "Nombre completo"),
            _input(Icons.videogame_asset, "Usuario del juego"),
            _input(Icons.tag, "ID del jugador"),
            _input(Icons.credit_card, "Cédula o pasaporte"),
            _input(Icons.flag, "País de residencia"),
            _input(Icons.school, "Nombre de la universidad"),
            _input(Icons.book, "Carrera que estudias"),
            _input(
              Icons.confirmation_number,
              "Matrícula o número de estudiante",
            ),
            _input(Icons.image, "Subir foto con jersey o poloche negro"),
            const SizedBox(height: 24),
            _botonVerificar(),
          ],
        ),
      ),
    );
  }

  Widget _input(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF1C1C1C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _botonVerificar() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          setState(() => verificado = true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Verificación exitosa"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black,
        ),
        child: const Text(
          "VERIFICAR AHORA",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
