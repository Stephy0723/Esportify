import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/connect_to_backend.dart';
import '../../widgets/Torneo/ModelTorneo.dart'; // Asegúrate de importar tu modelo

class DetalleTorneoPage extends StatefulWidget {
  final Torneo torneo;

  const DetalleTorneoPage({super.key, required this.torneo});

  @override
  State<DetalleTorneoPage> createState() => _DetalleTorneoPageState();
}

class _DetalleTorneoPageState extends State<DetalleTorneoPage> {
  final TextEditingController jugadorCtrl = TextEditingController();
  final TextEditingController equipoCtrl = TextEditingController();
  final TextEditingController miembroCtrl = TextEditingController();
  List<String> miembros = [];

  Future<void> agregarJugador() async {
    final url = '${ApiService.tournamentUrl}/${widget.torneo.id}/agregar-jugador';
    final body = {"userId": jugadorCtrl.text};

    final res = await http.patch(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Jugador agregado")));
      jugadorCtrl.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${res.body}")));
    }
  }

  Future<void> agregarEquipo() async {
    final url = '${ApiService.tournamentUrl}/${widget.torneo.id}/agregar-equipo';
    final body = {
      "teamName": equipoCtrl.text,
      "members": miembros.map((id) => {"role": "Miembro", "userId": id}).toList()
    };

    final res = await http.patch(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Equipo agregado")));
      equipoCtrl.clear();
      miembros.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${res.body}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final torneo = widget.torneo;

    return Scaffold(
      appBar: AppBar(title: Text(torneo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.network(torneo.logo, height: 100),
            const SizedBox(height: 8),
            Text("🎮 Juego: ${torneo.game}"),
            Text("📅 Fechas: ${torneo.startDate.toLocal().toString().split(' ')[0]} al ${torneo.endDate.toLocal().toString().split(' ')[0]}"),
            Text("📌 Categoría: ${torneo.category}"),
            Text("👥 Género: ${torneo.gender}"),
            Text("🔧 Modo: ${torneo.mode}"),
            Text("🏆 Premio: ${torneo.prize.type} - ${torneo.prize.value}"),
            const SizedBox(height: 12),
            const Text("📜 Reglas:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...torneo.rules.map((r) => Text("- ${r.title}: ${r.content}")),
            const SizedBox(height: 16),
            if (torneo.mode == "Individual") ...[
              const Text("👤 Agregar jugador"),
              TextField(controller: jugadorCtrl, decoration: const InputDecoration(labelText: "ID del jugador")),
              ElevatedButton(onPressed: agregarJugador, child: const Text("Agregar")),
              const SizedBox(height: 12),
              const Text("Jugadores actuales:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...torneo.players.map((p) => Text("• ${p.userId ?? 'Sin ID'}")),
            ] else ...[
              const Text("👥 Agregar equipo"),
              TextField(controller: equipoCtrl, decoration: const InputDecoration(labelText: "Nombre del equipo")),
              TextField(controller: miembroCtrl, decoration: const InputDecoration(labelText: "ID de miembro")),
              ElevatedButton(
                onPressed: () {
                  if (miembroCtrl.text.isNotEmpty) {
                    setState(() {
                      miembros.add(miembroCtrl.text);
                      miembroCtrl.clear();
                    });
                  }
                },
                child: const Text("Agregar miembro"),
              ),
              Wrap(children: miembros.map((m) => Chip(label: Text(m))).toList()),
              ElevatedButton(onPressed: agregarEquipo, child: const Text("Agregar equipo")),
              const SizedBox(height: 12),
              const Text("Equipos actuales:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...torneo.teams.map((t) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🏷️ ${t.teamName}"),
                  ...t.members.map((m) => Text("   • ${m.userId ?? 'Sin ID'}")),
                ],
              )),
            ],
          ],
        ),
      ),
    );
  }
}
