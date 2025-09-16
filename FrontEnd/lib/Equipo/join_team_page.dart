import 'package:flutter/material.dart';

class JoinTeamPage extends StatefulWidget {
  const JoinTeamPage({super.key});

  @override
  State<JoinTeamPage> createState() => _JoinTeamPageState();
}

class _JoinTeamPageState extends State<JoinTeamPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _orden = 'Relevancia';
  bool _soloReclutando = false;

  final List<Team> _allTeams = [
    Team(
      name: 'Shadow Wolves',
      tagline: 'Unleash the Darkness',
      members: 7,
      game: 'MLBB',
      tags: const ['Gold', 'Mid'],
      color: const Color(0xFF0EA5E9),
      icon: Icons.pets,
      recruiting: true,
    ),
    Team(
      name: 'Mystic Guardians',
      tagline: 'Guarding the Mystics',
      members: 5,
      game: 'LoL',
      tags: const ['Top'],
      color: const Color(0xFFA855F7),
      icon: Icons.bubble_chart,
      recruiting: false,
    ),
    Team(
      name: 'Inferno Squad',
      tagline: 'Burning Bright',
      members: 4,
      game: 'Valorant',
      tags: const ['Duelista', 'Centinela'],
      color: const Color(0xFFFB923C),
      icon: Icons.local_fire_department,
      recruiting: true,
    ),
    Team(
      name: 'Thunderstrike',
      tagline: 'Feel the Thunder',
      members: 8,
      game: 'LoL',
      tags: const ['Jungla'],
      color: const Color(0xFFFACC15),
      icon: Icons.flash_on,
      recruiting: true,
    ),
  ];

  List<Team> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    List<Team> list = _allTeams.where((t) {
      final matchesQ = q.isEmpty || t.name.toLowerCase().contains(q);
      final matchesRec = !_soloReclutando || t.recruiting;
      return matchesQ && matchesRec;
    }).toList();

    switch (_orden) {
      case 'Más miembros':
        list.sort((a, b) => b.members.compareTo(a.members));
        break;
      case 'Menos miembros':
        list.sort((a, b) => a.members.compareTo(b.members));
        break;
      case 'A-Z':
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      default:
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF0D0D0F);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text(
          'Buscar Equipos',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0.8,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown de orden
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF18181B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2A2E)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<String>(
                value: _orden,
                isExpanded: true,
                dropdownColor: const Color(0xFF18181B),
                decoration: const InputDecoration(border: InputBorder.none),
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white70,
                items: const [
                  DropdownMenuItem(
                    value: 'Relevancia',
                    child: Text('Relevancia'),
                  ),
                  DropdownMenuItem(
                    value: 'Más miembros',
                    child: Text('Más miembros'),
                  ),
                  DropdownMenuItem(
                    value: 'Menos miembros',
                    child: Text('Menos miembros'),
                  ),
                  DropdownMenuItem(value: 'A-Z', child: Text('A-Z')),
                ],
                onChanged: (v) => setState(() => _orden = v!),
              ),
            ),
            const SizedBox(height: 12),
            // Check reclutando
            InkWell(
              onTap: () => setState(() => _soloReclutando = !_soloReclutando),
              child: Row(
                children: [
                  Checkbox(
                    value: _soloReclutando,
                    onChanged: (v) =>
                        setState(() => _soloReclutando = v ?? false),
                    fillColor: WidgetStateProperty.resolveWith(
                      (s) => s.contains(WidgetState.selected)
                          ? Colors.white
                          : const Color(0xFF2A2A2E),
                    ),
                    checkColor: Colors.black,
                    side: const BorderSide(color: Color(0xFF3F3F46)),
                  ),
                  const Expanded(
                    child: Text(
                      'Solo mostrar equipos que están reclutando',
                      style: TextStyle(color: Colors.white, fontSize: 14.5),
                    ),
                  ),
                ],
              ),
            ),
            // Buscador
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF18181B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2A2E)),
              ),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Buscar por nombre',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Lista
            Expanded(
              child: ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) => _TeamCard(team: _filtered[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({required this.team});
  final Team team;

  void _showSuccessSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const SuccessSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = team.color;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111113),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border, width: 1.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: border.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(team.icon, color: border, size: 22),
            ),
            const SizedBox(width: 10),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título + miembros
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          team.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${team.members} miembros',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    team.tagline,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Chip(text: team.game),
                      ...team.tags.map((t) => _Chip(text: t)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        if (team.recruiting) {
                          _showSuccessSheet(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${team.name} no está reclutando ahora',
                              ),
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF1F1F23),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Unirme'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessSheet extends StatelessWidget {
  const SuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A1E), Color(0xFF121215)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF10B981).withOpacity(0.15),
              border: Border.all(color: const Color(0xFF10B981)),
            ),
            child: const Center(
              child: Icon(
                Icons.check_rounded,
                size: 34,
                color: Color(0xFF10B981),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Solicitud enviada',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '¡Listo! Tu solicitud fue enviada con éxito.\n'
            'Revisa tu correo, si eres aceptado recibirás la confirmación.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, height: 1.35),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F23),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF2F2F32)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12.5),
      ),
    );
  }
}

class Team {
  final String name;
  final String tagline;
  final int members;
  final String game;
  final List<String> tags;
  final Color color;
  final IconData icon;
  final bool recruiting;

  Team({
    required this.name,
    required this.tagline,
    required this.members,
    required this.game,
    required this.tags,
    required this.color,
    required this.icon,
    required this.recruiting,
  });
}
