const Tournament = require('../models/Tournament');

// Crear torneo
exports.createTournament = async (req, res) => {
  try {
    const { mode, players, teams, minParticipants, maxParticipants } = req.body;

    // Validación de modo
    if (!['Individual', 'Equipos'].includes(mode)) {
      return res.status(400).json({ error: 'Modo inválido. Debe ser "Individual" o "Equipos".' });
    }

    // Validación de estructura según modo
    if (mode === 'Individual') {
      if (!players || players.length < minParticipants || players.length > maxParticipants) {
        return res.status(400).json({
          error: `Cantidad de jugadores inválida. Debe estar entre ${minParticipants} y ${maxParticipants}.`
        });
      }
      if (teams && teams.length > 0) {
        return res.status(400).json({ error: 'No se deben enviar equipos en modo individual.' });
      }
    }

    if (mode === 'Equipos') {
      if (!teams || teams.length < minParticipants || teams.length > maxParticipants) {
        return res.status(400).json({
          error: `Cantidad de equipos inválida. Debe estar entre ${minParticipants} y ${maxParticipants}.`
        });
      }
      if (players && players.length > 0) {
        return res.status(400).json({ error: 'No se deben enviar jugadores individuales en modo por equipos.' });
      }
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
