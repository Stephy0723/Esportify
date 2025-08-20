const express = require('express');
const router = express.Router();
const mobaTeamController = require('../controllers/mobaTeamController');
const auth = require('../middlewares/authMiddleware');

router.post('/create', auth, mobaTeamController.createTeam);
router.post('/join', auth, mobaTeamController.joinTeam);

module.exports = router;