const mongoose = require('mongoose');

const gameSchema = new mongoose.Schema({
    name: { type: String, required: true, unique: true }, // Ej: MOBA, Free Fire
    roles: [{ type: String, required: true }], // Ej: ["EXP", "Gold", "Mid", "Jungla", "Roam"]
    
});

module.exports = mongoose.model('Game', gameSchema);
