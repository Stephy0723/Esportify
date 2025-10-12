const mongoose = require('mongoose');

const tournamentSchema = new mongoose.Schema(
    {
        name: { type: String, required: true },
        game: { type: String, required: true },
        gender: {
                    type: String,
                    enum: ['Masculino', 'Femenino', 'Mixto'],
                    required: true
                },
        mode: {
                    type: String,
                    enum: ['Individual', 'Equipos'],
                    required: true
                },
        players: [{
                    role: { type: String, required: true },
                    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }
                 }],
        teams: [{
                    teamName: { type: String, required: true },
                    members: [{
                    role: { type: String, required: true },
                    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }
                    }]
                 }],
        maxPlayers: { type: Number, required: true, default: 5 },
        minPlayers: { type: Number, required: true, default: 1 },
        category: {
                    type: String,
                    enum: ['Universitario', 'Abierto', 'Profesional'],
                    required: true
                },
        rules: [{
                    title: { type: String, required: true },
                    content: { type: String, required: true }
                }],
        prize: {
                    type: {
                        type: String,
                        enum: ['Dinero', 'Producto', 'Reconocimiento'],
                        default: 'Reconocimiento'
                    },
                    value: { type: String, default: 'none' }
                },
        verified: { type: Boolean, default: false },
        logo: {
                type: String,
                required: true,
                match: /^https?:\/\/.+\.(jpg|jpeg|png|svg)$/
              },
        qrCode: {
                    type: String,
                    match: /^https?:\/\/.+/
                },
        startDate: {
                    type: Date,
                    required: true
                    },
        endDate: {
                    type: Date,
                    required: true
                    },

    },{ timestamps: true }
)

module.exports = mongoose.model('Tournament', tournamentSchema);