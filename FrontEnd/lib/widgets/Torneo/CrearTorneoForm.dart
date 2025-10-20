import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/connect_to_backend.dart';


class CrearTorneoForm extends StatefulWidget {
  const CrearTorneoForm({super.key});

  @override
  State<CrearTorneoForm> createState() => _CrearTorneoFormState();
}

class _CrearTorneoFormState extends State<CrearTorneoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController gameCtrl = TextEditingController();
  final TextEditingController logoCtrl = TextEditingController();
  final TextEditingController qrCtrl = TextEditingController();
  final TextEditingController ruleTitleCtrl = TextEditingController();
  final TextEditingController ruleContentCtrl = TextEditingController();
  final TextEditingController prizeValueCtrl = TextEditingController();
  final TextEditingController minPlayersCtrl = TextEditingController();
  final TextEditingController maxPlayersCtrl = TextEditingController();



  String gender = "Mixto";
  String mode = "Individual";
  String category = "Abierto";
  String prizeType = "Reconocimiento";
  DateTime? startDate;
  DateTime? endDate;

  List<Map<String, String>> rules = [];
  List<Map<String, dynamic>> players = [];
  List<Map<String, dynamic>> teams = [];

  void seleccionarFecha(bool esInicio) async {
    final seleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (seleccionada != null) {
      setState(() {
        esInicio ? startDate = seleccionada : endDate = seleccionada;
      });
    }
  }

  void agregarRegla() {
    if (ruleTitleCtrl.text.isNotEmpty && ruleContentCtrl.text.isNotEmpty) {
      setState(() {
        rules.add({
          "title": ruleTitleCtrl.text,
          "content": ruleContentCtrl.text,
        });
        ruleTitleCtrl.clear();
        ruleContentCtrl.clear();
      });
    }
  }

Future<void> enviarFormulario() async {
  const url = ApiService.tournamentUrl;

  if (!_formKey.currentState!.validate()) return;

  if (startDate == null || endDate == null || startDate!.isAfter(endDate!)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fechas inválidas")),
    );
    return;
  }

  final body = {
    "name": nameCtrl.text,
    "game": gameCtrl.text,
    "gender": gender,
    "mode": mode,
    "category": category,
    "startDate": startDate!.toIso8601String(),
    "endDate": endDate!.toIso8601String(),
    "logo": logoCtrl.text,
    "qrCode": qrCtrl.text,
    "rules": rules,
    "prize": {
      "type": prizeType,
      "value": prizeValueCtrl.text,
    },
    "minPlayers": int.parse(minPlayersCtrl.text),
    "maxPlayers": int.parse(maxPlayersCtrl.text),
    "players": mode == "Individual" ? players : [],
    "teams": mode == "Equipos" ? teams : [],
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Torneo creado")),
      );
      Navigator.pop(context, true); // ← Cierra la pantalla si se creó correctamente
    } else {
      final error = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ ${error['error']}")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ Error: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nombre"), validator: (v) => v!.isEmpty ? "Requerido" : null),
            TextFormField(controller: gameCtrl, decoration: const InputDecoration(labelText: "Juego"), validator: (v) => v!.isEmpty ? "Requerido" : null),
            DropdownButtonFormField(value: gender, items: ["Masculino", "Femenino", "Mixto"].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(), onChanged: (v) => setState(() => gender = v!)),
            DropdownButtonFormField(value: mode, items: ["Individual", "Equipos"].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(), onChanged: (v) => setState(() => mode = v!)),
            DropdownButtonFormField(value: category, items: ["Universitario", "Abierto", "Profesional"].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => category = v!)),
            Row(
              children: [
                Expanded(child: Text(startDate == null ? "Inicio no seleccionada" : "Inicio: ${startDate!.toLocal().toString().split(' ')[0]}")),
                TextButton(onPressed: () => seleccionarFecha(true), child: const Text("Seleccionar inicio")),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(endDate == null ? "Fin no seleccionada" : "Fin: ${endDate!.toLocal().toString().split(' ')[0]}")),
                TextButton(onPressed: () => seleccionarFecha(false), child: const Text("Seleccionar fin")),
              ],
            ),
            TextFormField(controller: logoCtrl, decoration: const InputDecoration(labelText: "Logo (URL)"), validator: (v) => v!.isEmpty ? "Requerido" : null),
            TextFormField(controller: qrCtrl, decoration: const InputDecoration(labelText: "QR (URL)")),
            const SizedBox(height: 12),
            const Text("Premio"),
            DropdownButtonFormField(value: prizeType, items: ["Dinero", "Producto", "Reconocimiento"].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (v) => setState(() => prizeType = v!)),
            TextFormField(controller: prizeValueCtrl, decoration: const InputDecoration(labelText: "Valor del premio")),
            const SizedBox(height: 12),
            const Text("Reglas"),
            TextFormField(controller: ruleTitleCtrl, decoration: const InputDecoration(labelText: "Título")),
            TextFormField(controller: ruleContentCtrl, decoration: const InputDecoration(labelText: "Contenido")),
            TextFormField(
                          controller: minPlayersCtrl,
                          decoration: const InputDecoration(labelText: "Mínimo de participantes"),
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? "Requerido" : null,
                        ),
            TextFormField(
                          controller: maxPlayersCtrl,
                          decoration: const InputDecoration(labelText: "Máximo de participantes"),
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? "Requerido" : null,
                        ),

            ElevatedButton(onPressed: agregarRegla, child: const Text("Agregar regla")),
            Wrap(children: rules.map((r) => Chip(label: Text(r['title']!))).toList()),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: enviarFormulario,
              icon: const Icon(Icons.save),
              label: const Text("Crear torneo"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
