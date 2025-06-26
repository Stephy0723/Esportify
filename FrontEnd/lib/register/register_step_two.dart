// lib/register/register_step_two.dart

import 'package:flutter/material.dart';
import 'register_step_three.dart'; // Asegúrate de que exista este archivo

class RegisterStepTwo extends StatefulWidget {
  const RegisterStepTwo({super.key, required this.userData});

  final Map<String, String?> userData;

  @override
  State<RegisterStepTwo> createState() => _RegisterStepTwoState();
}

class _RegisterStepTwoState extends State<RegisterStepTwo> {
  // Iniciamos ambos en “No”
  bool perteneceEquipo = false;
  bool participoTorneos = false;

  final TextEditingController _equipoController = TextEditingController();
  String rolSeleccionado = 'Jugador';
  final List<String> roles = ['Jugador', 'Manager', 'Analista', 'Streamer'];

  final TextEditingController _torneoController = TextEditingController();
  final TextEditingController _fechaTorneoController = TextEditingController();
  DateTime? fechaTorneo;
  @override
  void dispose() {
    _equipoController.dispose();
    _torneoController.dispose();
    _fechaTorneoController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFechaTorneo(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.subtract(
        const Duration(days: 365 * 10),
      ), // 10 años atrás
      firstDate: DateTime(2000),
      lastDate: now,
      locale: const Locale('es', 'ES'),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
          dialogTheme: DialogThemeData(backgroundColor: Colors.white),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        fechaTorneo = picked;
        // Formateamos la fecha como "DD/MM/YYYY"
        _fechaTorneoController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  void _onNext() {
    // Aquí puedes validar campos si lo deseas...
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.check, size: 48, color: Colors.green),
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Listo!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Paso 2 completado.\nLos datos se guardaron correctamente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // cierra el diálogo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterStepThree(
                          userData: {
                            ...widget.userData,
                            'perteneceEquipo': perteneceEquipo.toString(),
                            'nombreEquipo': _equipoController.text,
                            'rolEquipo': rolSeleccionado,
                            'haParticipadoTorneos': participoTorneos.toString(),
                            'nombreTorneo': _torneoController.text,
                            'fechaTorneo': fechaTorneo?.toIso8601String(),
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                  ),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBack() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Equipos y Torneos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // ¿Perteneces a un equipo?
                const Text('¿Perteneces actualmente a un equipo?'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => setState(() => perteneceEquipo = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: perteneceEquipo
                              ? Colors.black
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Sí',
                          style: TextStyle(
                            color: perteneceEquipo
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            setState(() => perteneceEquipo = false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !perteneceEquipo
                              ? Colors.black
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: !perteneceEquipo
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Campos de equipo
                if (perteneceEquipo) ...[
                  TextFormField(
                    controller: _equipoController,
                    decoration: InputDecoration(
                      hintText: 'Nombre del equipo',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: rolSeleccionado,
                    decoration: InputDecoration(
                      hintText: 'Selecciona tu rol',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: roles
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (r) => setState(() => rolSeleccionado = r!),
                  ),
                  const SizedBox(height: 24),
                ],

                // ¿Has participado en torneos?
                const Text('¿Has participado en torneos antes?'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            setState(() => participoTorneos = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: participoTorneos
                              ? Colors.black
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Sí',
                          style: TextStyle(
                            color: participoTorneos
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            setState(() => participoTorneos = false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !participoTorneos
                              ? Colors.black
                              : Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: !participoTorneos
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Campos de torneo
                if (participoTorneos) ...[
                  TextFormField(
                    controller: _torneoController,
                    decoration: InputDecoration(
                      hintText: 'Nombre del torneo',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _seleccionarFechaTorneo(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _fechaTorneoController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          hintText: 'Fecha (DD/MM/YYYY)',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Botones atrás / siguiente
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: _onBack,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
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
      ),
    );
  }
}
