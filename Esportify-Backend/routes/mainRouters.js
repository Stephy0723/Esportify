const express = require('express');
const router = express.Router();
const mainControllers = require('../controllers/mainController');
const auth = require('../middlewares/authMiddleware');

// Solo la ruta principal
router.get('/main', auth, mainControllers.getMainPageData);

module.exports = router;