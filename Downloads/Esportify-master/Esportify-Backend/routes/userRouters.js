const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
// const auth = require('../middlewares/authMiddleware');

router.post('/register', userController.register);
router.post('/login', userController.login);
router.post('/check-user', userController.checkUserExists);

module.exports = router;