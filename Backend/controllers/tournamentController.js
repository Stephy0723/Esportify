const Tournament = require('../models/Tournament');

// Crear torneo
exports.createTournament = async (req, res) => {
  try {
    const {
      name,
      game,
      gender,
      category,
      mode,
      players,
      teams,
      minPlayers,
      maxPlayers,
      startDate,
      endDate,
      rules,
      prize,
      logo,
      qrCode
    } = req.body;

    // Validación básica
    if (!name || !game || !gender || !category || !mode || !startDate || !endDate || !logo) {
      return res.status(400).json({ error: 'Faltan campos obligatorios.' });
    }

    // Validación de fechas
    const start = new Date(startDate);
    const end = new Date(endDate);
    if (isNaN(start) || isNaN(end) || start >= end) {
      return res.status(400).json({ error: 'Fechas inválidas. La fecha de inicio debe ser anterior a la de finalización.' });
    }

    // Validación de modo
   if (!['Individual', 'Equipos'].includes(mode)) {
  return res.status(400).json({ error: 'Modo inválido. Debe ser "Individual" o "Equipos".' });
}

// Validación de cantidad numérica
if (typeof minPlayers !== 'number' || typeof maxPlayers !== 'number') {
  return res.status(400).json({ error: 'minPlayers y maxPlayers deben ser valores numéricos.' });
}

// Validación de rango lógico
if (minPlayers <= 0 || maxPlayers <= 0 || minPlayers > maxPlayers) {
  return res.status(400).json({ error: 'Rango inválido: minPlayers debe ser menor o igual a maxPlayers y ambos mayores a cero.' });
  }

    const tournament = new Tournament(req.body);
    await tournament.save();
    res.status(201).json(tournament);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


// Obtener todos los torneos
exports.getTournaments = async (req, res) => {
  try {
    const { page = 1, limit = 10, search = '' } = req.query;

    const query = search
      ? { name: { $regex: search, $options: 'i' } } // búsqueda insensible a mayúsculas
      : {};

    const tournaments = await Tournament.find(query)
      .populate('players.userId')
      .populate('teams.members.userId')
      .skip((page - 1) * limit)
      .limit(parseInt(limit));

    const total = await Tournament.countDocuments(query);

    res.status(200).json({
      total,
      page: parseInt(page),
      limit: parseInt(limit),
      totalPages: Math.ceil(total / limit),
      tournaments
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


// Obtener torneo por ID
exports.getTournamentById = async (req, res) => {
  try {
    const tournament = await Tournament.findById(req.params.id)
      .populate('players.userId')
      .populate('teams.members.userId');
    if (!tournament) return res.status(404).json({ error: 'Torneo no encontrado' });
    res.status(200).json(tournament);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Actualizar torneo
exports.updateTournament = async (req, res) => {
  try {
    const { startDate, endDate } = req.body;

    if (startDate && endDate) {
      const start = new Date(startDate);
      const end = new Date(endDate);
      if (isNaN(start) || isNaN(end) || start >= end) {
        return res.status(400).json({ error: 'Fechas inválidas. La fecha de inicio debe ser anterior a la de finalización.' });
      }
    }

    const updated = await Tournament.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true
    });

    if (!updated) return res.status(404).json({ error: 'Torneo no encontrado' });
    res.status(200).json(updated);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


// Eliminar torneo
exports.deleteTournament = async (req, res) => {
  try {
    const deleted = await Tournament.findByIdAndDelete(req.params.id);
    if (!deleted) return res.status(404).json({ error: 'Torneo no encontrado' });
    res.status(200).json({ message: 'Torneo eliminado correctamente' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// PATCH /torneos/:id/agregar-jugador
exports.agregarJugador = async (req, res) => {
  try {
    const { userId } = req.body;
    const torneo = await Tournament.findById(req.params.id);

    if (!torneo) return res.status(404).json({ error: 'Torneo no encontrado' });
    if (torneo.mode !== 'Individual') return res.status(400).json({ error: 'Este torneo no es individual' });

    if (torneo.players.length >= torneo.maxPlayers) {
      return res.status(400).json({ error: 'Ya se alcanzó el máximo de jugadores' });
    }

    torneo.players.push({ role: 'Jugador', userId });
    await torneo.save();

    res.json({ message: 'Jugador agregado', torneo });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

// PATCH /torneos/:id/agregar-equipo
exports.agregarEquipo = async (req, res) => {
  try {
    const { teamName, members } = req.body;
    const torneo = await Tournament.findById(req.params.id);

    if (!torneo) return res.status(404).json({ error: 'Torneo no encontrado' });
    if (torneo.mode !== 'Equipos') return res.status(400).json({ error: 'Este torneo no es por equipos' });

    if (torneo.teams.length >= torneo.maxPlayers) {
      return res.status(400).json({ error: 'Ya se alcanzó el máximo de equipos' });
    }

    torneo.teams.push({ teamName, members });
    await torneo.save();

    res.json({ message: 'Equipo agregado', torneo });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};
