const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const auth = require('../middlewares/authMiddleware');

router.post('/register', auth, userController.register);
router.post('/login', auth, userController.login);
router.post('/check-user', auth, userController.checkUserExists);

module.exports = router;