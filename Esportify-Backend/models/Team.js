const mongoose = require('mongoose');

// Subdocumento para info de verificación de jugador/coach
const memberDataSchema = new mongoose.Schema({
  nickname: { type: String },   // gamer tag
  experience: { type: Number }, // años de experiencia
  rank: { type: String },       // rango dentro del juego

  // Si es universitario
  studentId: { type: String },
  faculty: { type: String },

  // Info común
  documentId: { type: String }, // cédula/pasaporte
  image: { type: String }       // foto verificación
}, { _id: false });

const playerSchema = new mongoose.Schema({
  role: { type: String, required: true }, // Ej: "Mid", "EXP"
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  memberData: memberDataSchema,
  status: { type: String, enum: ["pending", "accepted", "rejected"], default: "pending" }
}, { _id: false });

const substituteSchema = new mongoose.Schema({
  role: { type: String },
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  memberData: memberDataSchema,
  status: { type: String, enum: ["pending", "accepted", "rejected"], default: "pending" }
}, { _id: false });

const teamSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true },
  logo: { type: String, required: true },
  gender: { type: String, enum: ["Masculino", "Femenino", "Mixto"], required: true },

  isUniversity: { type: Boolean, default: false },
  university: { type: String }, // opcional

  country: {
    type: String,
    enum: [
      "Argentina","Bolivia","Brasil","Chile","Colombia","Costa Rica","Cuba",
      "República Dominicana","Ecuador","El Salvador","Guatemala","Honduras","Mexico",
      "Nicaragua","Panama","Paraguay","Peru","Uruguay","Venezuela"
    ],
    required: true
  },

  // Referencia al juego
  game: { type: mongoose.Schema.Types.ObjectId, ref: "Game", required: true },

  // Miembros
  players: [playerSchema],         // titulares
  substitutes: [substituteSchema], // máximo 2
  coach: { type: mongoose.Schema.Types.ObjectId, ref: "User" },

  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },

  verified: { type: Boolean, default: false },
  qrCode: { type: String }
}, { timestamps: true });

module.exports = mongoose.model("Team", teamSchema);
