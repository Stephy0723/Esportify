class Torneo {
  final String id;
  final String name;
  final String game;
  final String gender;
  final String mode;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final String logo;
  final String qrCode;
  final bool verified;
  final Prize prize;
  final List<Rule> rules;
  final List<Player> players;
  final List<Team> teams;

  Torneo({
    required this.id,
    required this.name,
    required this.game,
    required this.gender,
    required this.mode,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.logo,
    required this.qrCode,
    required this.verified,
    required this.prize,
    required this.rules,
    required this.players,
    required this.teams,
  });

  factory Torneo.fromJson(Map<String, dynamic> json) {
    return Torneo(
      id: json['_id'],
      name: json['name'],
      game: json['game'],
      gender: json['gender'],
      mode: json['mode'],
      category: json['category'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      logo: json['logo'],
      qrCode: json['qrCode'],
      verified: json['verified'] ?? false,
      prize: Prize.fromJson(json['prize']),
      rules: (json['rules'] as List).map((r) => Rule.fromJson(r)).toList(),
      players: (json['players'] as List).map((p) => Player.fromJson(p)).toList(),
      teams: (json['teams'] as List).map((t) => Team.fromJson(t)).toList(),
    );
  }
}

//Submodelos
class Prize {
  final String type;
  final String value;

  Prize({required this.type, required this.value});

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      type: json['type'],
      value: json['value'],
    );
  }
}
class Rule {
  final String title;
  final String content;

  Rule({required this.title, required this.content});

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      title: json['title'],
      content: json['content'],
    );
  }
}
class Player {
  final String role;
  final String? userId;

  Player({required this.role, this.userId});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      role: json['role'],
      userId: json['userId'],
    );
  }
}
class Team {
  final String teamName;
  final List<Player> members;

  Team({required this.teamName, required this.members});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamName: json['teamName'],
      members: (json['members'] as List).map((m) => Player.fromJson(m)).toList(),
    );
  }
}

