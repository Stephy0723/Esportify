import 'package:flutter/material.dart';

class FormularioReclutamientoPage extends StatelessWidget {
  final String modalidad;
  final List<String> lineas;

  const FormularioReclutamientoPage({
    super.key,
    required this.modalidad,
    required this.lineas,
  });

  @override
  Widget build(BuildContext context) {
    final campos = _getCamposPorModalidad(modalidad);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Reclutamiento - $modalidad',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Text(
              "Líneas seleccionadas: ${lineas.join(', ')}",
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            ...campos.map((label) => _campo(label)).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Enviar formulario",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getCamposPorModalidad(String modalidad) {
    switch (modalidad) {
      case 'MOBA':
        return [
          'Nombre',
          'Edad',
          'Lane principal',
          'Héroe favorito',
          'Experiencia competitiva',
        ];
      case 'Battle Royale':
        return [
          'Nombre',
          'Edad',
          'Rol (rush, sniper, etc.)',
          'K/D promedio',
          'Disponibilidad',
        ];
      case 'Fighting':
        return [
          'Nombre',
          'Personaje principal',
          'Plataforma (PS5, PC, etc.)',
          'Torneos jugados',
        ];
      case 'FPS Táctico':
        return [
          'Nombre',
          'Rol (Entry, Support)',
          'Agente favorito',
          'Nivel de rango',
          'Micro y conexión',
        ];
      case 'Sports':
        return [
          'Nombre',
          'Juego (FIFA, NBA)',
          'Plataforma',
          'Equipo favorito',
          'Estilo de juego',
        ];
      case 'Arcade':
        return ['Nombre', 'Juego', 'Nivel de dedicación', 'Puntaje promedio'];
      case 'Carreras':
        return [
          'Nombre',
          'Juego principal',
          'Volante o control',
          'Pista favorita',
          'Tiempo promedio',
        ];
      default:
        return ['Nombre', 'Experiencia', 'Juego principal'];
    }
  }

  Widget _campo(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
