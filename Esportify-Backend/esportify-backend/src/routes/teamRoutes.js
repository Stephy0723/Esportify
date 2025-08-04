const express = require('express');
const router = express.Router();
const TeamController = require('../controllers/teamController');

const teamController = new TeamController();

// Route to create a new team
router.post('/', teamController.createTeam);

// Additional routes for team-related operations can be added here

module.exports = router;