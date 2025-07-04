import 'package:flutter/material.dart';
import 'Modalidad/crear_moba.dart';
import 'Modalidad/crear_battle_royale.dart';
import 'Modalidad/crear_fighting.dart';
import 'Modalidad/crear_shooter.dart';
import 'Modalidad/crear_sports.dart';
import 'Modalidad/estrategia_form.dart';

class CrearEquipoPage extends StatefulWidget {
  const CrearEquipoPage({super.key});

  @override
  State<CrearEquipoPage> createState() => _CrearEquipoPageState();
}

class _CrearEquipoPageState extends State<CrearEquipoPage> {
  String? modalidadSeleccionada;

  final Map<String, Widget> formularios = {
    "MOBA": const MobaForm(),
    "Battle Royale": const BattleRoyaleForm(),
    "Fighting": const FightingForm(),
    "Shooter": const ShooterForm(),
    "Sports": const SportForm(),
    "Estrategia": const EstrategiaForm(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Crear Equipo",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selecciona una modalidad:",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.black,
                value: modalidadSeleccionada,
                decoration: const InputDecoration(border: InputBorder.none),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                style: const TextStyle(color: Colors.white),
                items: formularios.keys.map((modo) {
                  return DropdownMenuItem(
                    value: modo,
                    child: Text(
                      modo,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => modalidadSeleccionada = value);
                },
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: modalidadSeleccionada != null
                    ? formularios[modalidadSeleccionada]!
                    : const Center(
                        child: Text(
                          "Selecciona una modalidad para continuar",
                          style: TextStyle(color: Colors.white38),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
