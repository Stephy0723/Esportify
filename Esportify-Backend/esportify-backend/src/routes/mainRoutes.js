const express = require('express');
const router = express.Router();
const MainController = require('../controllers/mainController');

const mainController = new MainController();

// Route to get the main page based on user selections
router.get('/', mainController.getMainPage);

module.exports = router;