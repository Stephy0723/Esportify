const mongoose = require('mongoose');

const mainSchema = new mongoose.Schema({
    titulo: { type: String, required: true },
    descripcion: { type: String, required: true },
    fecha: { type: Date, required: true },
    juego: {
        type: String,
        enum: ['MOBA', 'FPS', 'Battle Royale', 'Card Game', 'RPG'],
        required: true,
    },
    creador: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    participantes: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    }],
    estado: {
        type: String,
        enum: ['Pendiente', 'En Progreso', 'Finalizado'],
        default: 'Pendiente',
    },
}, { timestamps: true });

module.exports = mongoose.model('Evento', mainSchema);