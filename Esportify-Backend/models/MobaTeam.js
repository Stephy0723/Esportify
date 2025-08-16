const mongoose = require('mongoose');

const mobaTeamSchema = new mongoose.Schema({
    game: {
        type: String,
        enum: ['MOBA'],
        required: true
    },
    mobaGames: {
        type: String,
        enum: ['Mobile Legends', 'League of Legends', 'Wild Rift', 'Arena of Valor', 'Pokemon Unite'],
        required: true
    },
    image: {
        type: String,
        required: true
    },
    slogan: { type: String, required: true },

    teamGender: {
        type: String,
        enum: ['Masculino', 'Femenino', 'Mixto'],
        required: true,
    },

    universitario: { type: Boolean, default: false },
    universidad: { type: String, default: '', required: true },

    teamCountrys: {
        type: String, enum: [
            'Argentina',
            'Bolivia',
            'Brasil',
            'Chile',
            'Colombia',
            'Costa Rica',
            'Cuba',
            'República Dominicana',
            'Ecuador',
            'El Salvador',
            'Guatemala',
            'Honduras',
            'Mexico',
            'Nicaragua',
            'Panama',
            'Paraguay',
            'Peru',
            'Uruguay',
            'Venezuela',
        ], required: true
    },


    exp: { type: mongoose.Schema.Types.ObjectId, ref: 'Titular' }, // Experiencia del equipo
    gold: { type: mongoose.Schema.Types.ObjectId, ref: 'Titular' }, // Oro del equipo
    mid: { type: mongoose.Schema.Types.ObjectId, ref: 'Titular' }, // Mid del equipo
    jungla: { type: mongoose.Schema.Types.ObjectId, ref: 'Titular' }, // Jungla del equipo
    roam: { type: mongoose.Schema.Types.ObjectId, ref: 'Titular' }, // Roam del equipo

    suplente1: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Sustituto',
    }],
    suplente2: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Sustituto',
    }],

    coach: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Coach',
        required: true,
    }
}, { timestamps: true });

module.exports = mongoose.model('MobaTeam', mobaTeamSchema);