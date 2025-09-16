const mongoose = require('mongoose');

const teamSchema = new mongoose.Schema({
    name: { type: String, required: true },
    logo: { type: String, required: true },
    gender: {
        type: String,
        enum: ['Masculino', 'Femenino', 'Mixto'],
        required: true
    },
    isUniversity: { type: Boolean, default: false },
    university: { type: String, default: '' },
    country: {
        type: String,
        enum: [
            'Argentina', 'Bolivia', 'Brasil', 'Chile', 'Colombia', 'Costa Rica', 'Cuba',
            'República Dominicana', 'Ecuador', 'El Salvador', 'Guatemala', 'Honduras', 'Mexico',
            'Nicaragua', 'Panama', 'Paraguay', 'Peru', 'Uruguay', 'Venezuela'
        ],
        required: true
    },
    game: { type: mongoose.Schema.Types.ObjectId, ref: 'Game', required: true }, 
    players: [{
    role: { type: String, required: true }, // Ej: EXP, Mid
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }
}],
    substitutes: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    coach: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },

    coach: { type: mongoose.Schema.Types.ObjectId, ref: 'Coach' },
    qrCode: { type: String },
    verified: { type: Boolean, default: false }
    
}, { timestamps: true });

module.exports = mongoose.model('Team', teamSchema);
