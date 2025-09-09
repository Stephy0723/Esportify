const mongoose = require('mongoose');

const gameSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true }, // Ej: "Mobile Legends"
  genre: { type: String, enum: ["MOBA", "FPS", "Battle Royale"], required: true },
  roles: [{ type: String, required: true }] // Ej: ["EXP", "Mid", "Jungla", "Roam", "Gold"]
}, { timestamps: true });

module.exports = mongoose.model("Game", gameSchema);
