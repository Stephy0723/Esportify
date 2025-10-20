import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/connect_to_backend.dart';
import '../Torneo/CrearTorneoForm.dart';
import '../Torneo/ModelTorneo.dart';
import '../../page/Torneo/DetalleTorneoPage.dart';


class TorneosSection extends StatefulWidget {
  const TorneosSection({super.key});

  @override
  State<TorneosSection> createState() => _TorneosSectionState();
}

class _TorneosSectionState extends State<TorneosSection> {
  List<Torneo> torneos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarTorneos();
  }

  Future<void> cargarTorneos() async {
    const url = ApiService.tournamentUrl;
    try {
      final response = await http.get(Uri.parse('$url?page=1&limit=10'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> lista = data['tournaments'];

        setState(() {
          torneos = lista.map((json) => Torneo.fromJson(json)).toList();
          cargando = false;
        });
      } else {
        throw Exception("Error al cargar torneos");
      }
    } catch (e) {
      setState(() {
        torneos = [];
        cargando = false;
      });
    }
  }

Widget torneoBox(Torneo torneo) {
  return SizedBox(
    width: 220,
    height: 150, // altura ajustada para evitar overflow
    child: Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetalleTorneoPage(torneo: torneo),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                torneo.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                torneo.game,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                "📅 ${torneo.startDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Text(
                "📅 ${torneo.endDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward, color: Colors.amber, size: 20),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  void crearTorneo() async {
  final resultado = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Crear Torneo"),
      content: const CrearTorneoForm(),
    ),
  );

  if (resultado == true) {
    await cargarTorneos(); // ← recarga solo si se creó el torneo
  }
}


  void mostrarDetalles(Torneo torneo) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(torneo.name),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Juego: ${torneo.game}"),
            Text("Modo: ${torneo.mode}"),
            Text("Fechas: ${torneo.startDate.toLocal()} al ${torneo.endDate.toLocal()}"),
            Text("Premio: ${torneo.prize.type} - ${torneo.prize.value}"),
            const SizedBox(height: 8),
            Text("Reglas:", style: const TextStyle(fontWeight: FontWeight.bold)),
            ...torneo.rules.map((r) => Text("- ${r.title}: ${r.content}")),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cerrar")),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Torneos disponibles",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: crearTorneo,
              icon: const Icon(Icons.add_circle_outline),
              tooltip: "Crear torneo",
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: cargando
              ? const Center(child: CircularProgressIndicator())
              : torneos.isEmpty
                  ? const Center(
                      child: Text(
                        "⚠️ No existen torneos disponibles",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: torneos.map(torneoBox).toList(),
                    ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
