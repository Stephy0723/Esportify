const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const auth = require('../middlewares/authMiddleware');

router.post('/register', userController.register);
router.post('/login', userController.login);
router.post('/check-user', userController.checkUserExists);
router.get('/confirmEmail/:token', userController.confirmEmail);
/*router.post('/forgot-password', userController.forgotPassword);//Aun  no esta implementado, pero se utilizara para enviar un email de recuperacion de contraseña*/

router.get('/profile', auth, userController.getUserProfile);
router.put('/profile', auth, userController.updateUserProfile);
router.delete('/profile', auth, userController.deleteUserProfile);

module.exports = router;