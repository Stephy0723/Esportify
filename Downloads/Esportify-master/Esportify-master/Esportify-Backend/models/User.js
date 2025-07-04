const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({ 
  username: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },

  fechaNacimiento: { type: Date, required: true },
  genero: { type: String, enum: ['Masculino', 'Femenino', 'Otro'], default: 'Masculino', required: true },
  pais: { type: String, required: true },
  provincia: { type: String, required: true },

  perteneceEquipo: { type: Boolean, default: false },
  nombreEquipo: { type: String},
  rolEnEquipo: { type: String },
  haParticipadoTorneos: { type: Boolean, default: false },
  nombreTorneo: { type: String },
  fechaTorneo: { type: Date },

  juegosFavoritos: { type: String, enum: ['lol', 'hok', 'mlbb','mk','sf6','tft','wildrift','marvel','freefire'], required: true},
  plataformas: { type: String, enum: ['PC', 'PS4', 'Xbox','Switch', 'Móvil'], required: true },
  juegoPersonalizado: { type: String, default: 'Ninguno' },

  aceptaTerminos: { type: Boolean, default: false },
  aceptaPrivacidad:{ type: Boolean, default: false },
  notificaciones: { type: Boolean, default: true },

});

module.exports = mongoose.model('User', userSchema);
