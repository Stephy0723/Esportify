const Team = require('../models/MobaTeam');
const User = require('../models/User');

exports.createTeam = async (req, res) => {
    try {
        const { game, image, slogan, teamGender, } = req.body;

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
            universitario: req.body.universitario || false,
            universidad: req.body.universidad || '',
            teamCountrys: req.body.teamCountrys || '',
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