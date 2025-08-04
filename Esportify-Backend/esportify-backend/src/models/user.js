const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
        unique: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    preferences: {
        type: [String],
        default: []
    }
}, {
    timestamps: true
});

module.exports = mongoose.model('User', userSchema);