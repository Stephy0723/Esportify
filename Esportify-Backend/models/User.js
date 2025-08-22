const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  status: {type: String, required: true, default: 'UNVERIFIED'},
  tokenConfirm: { type: String, default: null }, // Token de confirmación
  password: { type: String, required: true },
  resetCode: {  type: String,  default: null  }, // Código de restablecimiento de contraseña
  resetCodeExpires: { type: Date, default: null }, // Fecha de expiración del código de restablecimiento

  fechaNacimiento: { type: Date, required: true },
  genero: { type: String, enum: ['Masculino', 'Femenino', 'Otro'], default: 'Masculino', required: true },
  pais: { type: String, required: true },
  provincia: { type: String, required: true },

  perteneceEquipo: { type: Boolean, default: false },
  equipo: { type: mongoose.Schema.Types.ObjectId, ref: 'Team' },
  rolEnEquipo: { type: String },

  torneos: [{  // Historial de torneos
    nombre: { type: String },
    fecha: { type: Date }
  }],

  juegosFavoritos: [{ type: String, enum: ['lol', 'hok', 'mlbb', 'mk', 'sf6', 'tft', 'wildrift', 'marvel', 'freefire'], required: true }],
  plataformas: [{ type: String, enum: ['PC', 'PlayStation', 'Xbox', 'Switch', 'Móvil'] }],
  juegoPersonalizado: { type: String, default: 'Ninguno' },

// Campos universitarios
  esUniversitario: { type: Boolean, default: false },
  universidad: { type: String, default: '' },
  carrera: { type: String, default: '' },
  matricula: { type: String, default: '' }, // número de estudiante o registro

  aceptaTerminos: { type: Boolean, default: false },
  aceptaPrivacidad: { type: Boolean, default: false },
  notificaciones: { type: Boolean, default: true },

}, { timestamps: true });

module.exports = mongoose.model('User', userSchema);
