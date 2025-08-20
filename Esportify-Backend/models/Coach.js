const mogoose = require('mongoose');

const coachSchema = new mogoose.Schema({
    fullname: { type: String, required: true },
    cedula: {type: String, required: true, unique: true },
    expage: { type: Number, required: true }, // Años de experiencia
    teamsexperience: { type: Number, required: true }, // Experiencia con equipos
    createImageBitmap: { type: String }, // URL de la imagen del coach
    phoneNumber: { type: String, required: true }, // Número de teléfono del coach
    prophoto: {type: String, required: true}, // Foto profesional del coach
});

module.exports = mongoose.model('Coach', coachSchema);