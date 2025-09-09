const express = require('express');
const router = express.Router();
const TeamController = require('../controllers/teamController');
const auth = require('../middlewares/authMiddleware');

router.post('/create', auth, TeamController.createTeam);
router.post('/join', auth, TeamController.joinTeam);

module.exports = router;