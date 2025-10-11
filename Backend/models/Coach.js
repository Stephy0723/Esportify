const mongoose = require('mongoose');

const CoachSchema = new mongoose.Schema({
    name: {type: String, required: true},
    id: {type: String, required: true},
    experienceAge: {type: Number, required: true},
    lastTeam: {type: String, required: true},
    certifications: [{type: String}],
    number: {type: Number, required: true},
    image: {type: String, required: true}
});

module.exports = mongoose.model('Coach', CoachSchema);
