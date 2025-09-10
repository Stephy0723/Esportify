const Team = require('../models/Team');
const User = require('../models/User');

exports.createTeam = async (req, res) => {
  try {
    const { game, logo, name, gender, isUniversity, university, country, coach } = req.body;

    // Verificar si el equipo ya existe
    const existingTeam = await Team.findOne({ name });
    if (existingTeam) {
      return res.status(400).json({ message: 'El nombre del equipo ya existe.' });
    }

    // Crear el equipo
    const team = new Team({
      game,
      logo,                    
      name,
      gender,                 
      isUniversity: isUniversity ?? false,
      university: university ?? '',
      country,
      coach: coach ?? null,
      players: [],              
      substitutes: [],          
    });

    await team.save();

    // Actualizar al usuario que creó el equipo
    await User.findByIdAndUpdate(req.user._id, {
      perteneceEquipo: true,
      equipo: team._id
    });

    res.status(201).json({ message: 'Equipo creado con éxito.', team });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error al crear el equipo.' });
  }
};


exports.joinTeam = async (req, res) => {
    try {

    } catch (error) {
        console.error(error);
        res.status(500).json({ messege: 'Error al unirse al equipo' });
    }
}

exports.leaveTeam = async (req, res) => {
    try {
        const userId = req.user._id;
        const team = await Team.findOne({ $or: [{ top: userId }, { jungle: userId }, { mid: userId }, { adc: userId }, { support: userId }, { coach: userId }, { suplente1: userId }, { suplente2: userId }] });

        if (!team) {
            return res.status(404).json({ messege: 'No estás en ningún equipo.' });
        }

        for (const role of ['top', 'jungle', 'mid', 'adc', 'support', 'coach', 'suplente1', 'suplente2']) {
            if (Array.isArray(team[role])) {
                team[role] = team[role].filter(id => id.toString() !== userId.toString());
            } else if (team[role]?.toString() === userId.toString()) {
                team[role] = null;
            }
        }

        await team.save();

        await User.findByIdAndUpdate(userId, {
            perteneceEquipo: false,
            equipo: null,
            rolEnEquipo: null
        });

        res.status(200).json({ messege: 'Has abandonado el equipo con éxito.', team });
    } catch (error) {
        console.error(error);
        res.status(500).json({ messege: 'Error al abandonar el equipo.' });
    }
}

exports.getTeamProfile = async (req, res) => {
    try {
        const teamId = req.params.teamId;
        const team = await Team.findById(teamId)
            .populate('top', 'username email rolEnEquipo')
            .populate('jungle', 'username email rolEnEquipo')
            .populate('mid', 'username email rolEnEquipo')
            .populate('adc', 'username email rolEnEquipo')
            .populate('support', 'username email rolEnEquipo')
            .populate('coach', 'username email rolEnEquipo')
            .populate('suplente1', 'username email rolEnEquipo')
            .populate('suplente2', 'username email rolEnEquipo');

        if (!team) {
            return res.status(404).json({ messege: 'Equipo no encontrado.' });
        }

        res.status(200).json({ messege: 'Perfil del equipo obtenido con éxito.', team });
    } catch (error) {
        console.error(error);
        res.status(500).json({ messege: 'Error al obtener el perfil del equipo.' });
    }
}

exports.updateTeamProfile = async (req, res) => {
    try {
        const teamId = req.params.teamId;
        const updates = req.body;

        const team = await Team.findByIdAndUpdate(teamId, updates, { new: true });

        if (!team) {
            return res.status(404).json({ messege: 'Equipo no encontrado.' });
        }

        res.status(200).json({ messege: 'Perfil del equipo actualizado con éxito.', team });
    } catch (error) {
        console.error(error);
        res.status(500).json({ messege: 'Error al actualizar el perfil del equipo.' });
    }
};

exports.deleteTeam = async (req, res) => {
    try {
        const teamId = req.params.teamId;
        const team = await Team.findByIdAndDelete(teamId);

        if (!team) {
            return res.status(404).json({ messege: 'Equipo no encontrado.' });
        }

        res.status(200).json({ messege: 'Equipo eliminado con éxito.', team });
    } catch (error) {
        console.error(error);
        res.status(500).json({ messege: 'Error al eliminar el equipo.' });
    }
};