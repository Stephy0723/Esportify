const express = require('express');
const router = express.Router();
const tournamentController = require('../controllers/tournamentController');

router.post('/', tournamentController.createTournament);
router.get('/', tournamentController.getTournaments);
router.get('/', tournamentController.getTournamentById);
router.put('/:id', tournamentController.updateTournament);
router.delete('/:id', tournamentController.deleteTournament);

module.exports = router;
