const mongoose = require('mongoose');

const substitutesSchema = new mongoose.Schema({
    fullname: {type: String, required: true},
    usernamegame: {type: String, required: true, unique: true},
    id: {type: String, required: true, unique: true},
    cedula: {type: Number, required: true, unique: true},
    country: {type: String, required: true},
    photoJersey: {type: String, required: true},
});

module.exports = mongoose.model('Substituto', substitutesSchema);