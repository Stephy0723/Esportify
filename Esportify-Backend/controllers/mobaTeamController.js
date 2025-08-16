const Team = require('../models/MobaTeam');
const User = require('../models/User');

exports.createTeam = async (req, res) => {
    try {
        const { game, mobaGames, image, slogan, teamGender, universitario, universidad, teamCountrys, coach } = req.body;

        const existingteam = await Team.findOne({ slogan });
        if (existingteam) {
            return res.status(400).json({ messege: 'El nombre del equipo ya existe.' });
        }

        const team = new Team({
            game,
            mobaGames,
            image,
            slogan,
            teamGender,
            universitario: universitario ?? false,
            universidad: universidad ?? '',
            teamCountrys: teamCountrys ?? '',
            coach: coach ?? null,
        });

        await team.save();

        await User.findByIdAndUpdate(req.user._id, {
            perteneceEquipo: true,
            equipo: team._id
        });

        res.status(201).json({ messege: 'Equipo creado con exito.', team });
    } catch (error) {
        console.error(error);
        res.status(500).json({ messege: 'Error al crear el equipo.' });
    }
};

exports.joinTeam = async (req, res) => {
    try {
        const { teamId, rol } = req.body;

        const team = await Team.findById(teamId);
        if (!team) {
            return res.status(404).json({ messege: 'Equipo no encontrado.' });
        }

        // Verifica si el usuario ya ocupa ese rol
        if (team[rol] && Array.isArray(team[rol]) ? team[rol].includes(req.user._id) : team[rol]?.toString() === req.user._id.toString()) {
            return res.status(400).json({ messege: 'Ya eres parte de este equipo.' });
        }

        // Validación para suplentes (máximo 1 por campo)
        if (rol === 'suplente1' || rol === 'suplente2') {
            if (team[rol].length >= 1) {
                return res.status(400).json({ messege: 'El rol de suplente ya está ocupado.' });
            }
            team[rol].push(req.user._id);
        } else {
            // Validación para titulares y coach (solo uno por rol)
            if (team[rol]) {
                return res.status(400).json({ messege: `El rol ${rol} ya está ocupado.` });
            }
            team[rol] = req.user._id;
        }
        await team.save();

        await User.findByIdAndUpdate(req.user._id, {
            perteneceEquipo: true,
            equipo: team._id,
            rolEnEquipo: rol
        });

        res.status(200).json({ messege: 'Te has unido al equipo con exito.', team });

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

        // Elimina al usuario del equipo
        for (const role of ['top', 'jungle', 'mid', 'adc', 'support', 'coach', 'suplente1', 'suplente2']) {
            if (Array.isArray(team[role])) {
                team[role] = team[role].filter(id => id.toString() !== userId.toString());
            } else if (team[role]?.toString() === userId.toString()) {
                team[role] = null;
            }
        }

        await team.save();

        // Actualiza el usuario
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