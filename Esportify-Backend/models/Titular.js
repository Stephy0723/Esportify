const mongoose = require('mongoose');

const titularSchema = new mongoose.Schema({
    fullname: {type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true},
    usernamegame: {type: String, required: true, unique: true},
    id: {type: String, required: true, unique: true},
    cedula: {type: Number, required: true, unique: true},
    country:{type: String, required: true},
    photoJersey: {type: String, required: true},
    isUniversitary: {type: Boolean, default: false},
    nameUniversity: {type: String, required: function () {
        return this.isUniversitary === true
    }},
    carrier: {type: String,required: function () {
        return this.isUniversitary === true
    }},
    matricula: {type: String, required: function () {
        return this.isUniversitary === true
    }}
});

module.exports = mongoose.model('Titular', titularSchema);

