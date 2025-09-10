const mongoose = require('mongoose');

const gameSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true },
  genre: { type: String, enum: ["MOBA"], required: true },
  roles: [{ type: String, required: true }] // Ej: ["EXP", "Mid", "Jungla", "Roam", "Gold"]
}, { timestamps: true });

module.exports = mongoose.model("Game", gameSchema);
