const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const { v4: uuidv4 } = require('uuid');
const { getTemplate } = require('../config/mail.config');
const { sendEmail } = require('../config/mail.config');


exports.register = async (req, res) => {
  try {
    const {
      username,
      name,
      email,
      password,
      fechaNacimiento,
      genero,
      pais,
      provincia,
      perteneceEquipo,
      nombreEquipo,
      rolEnEquipo,
      haParticipadoEnTorneos,
      nombreTorneo,
      fechaTorneo,
      juegosFavoritos,
      plataformas,
      juegoPersonalizado,
      aceptaTerminos,
      aceptaPrivacidad,
      notificaciones,
    } = req.body;

    const existingUser = await User.findOne({ email, username });
    if (existingUser) return res.status(400).json({ message: 'Usuario ya existe' });

    const hashedPassword = await bcrypt.hash(password, 10);

    const tokenConfirm = uuidv4(); // Genera un token único

    const newUser = new User({
      username,
      name,
      email,
      password: hashedPassword,
      tokenConfirm: tokenConfirm, // Guarda el token de confirmación generado
      fechaNacimiento,
      genero,
      pais,
      provincia,
      perteneceEquipo,
      nombreEquipo,
      rolEnEquipo,
      haParticipadoEnTorneos,
      nombreTorneo,
      fechaTorneo,
      juegosFavoritos,
      plataformas,
      juegoPersonalizado,
      aceptaTerminos,
      aceptaPrivacidad,
      notificaciones,
    });

    const emailTemplate = getTemplate(name, tokenConfirm);
    await sendEmail(email, 'Confirma tu cuenta en Esportify', emailTemplate);

    await newUser.save();

    const token = jwt.sign({ id: newUser._id, username: newUser.username }, process.env.JWT_SECRET,
      { expiresIn: '2h' });

    res.status(201).json({ token, userId: newUser._id });
  } catch (error) {
    if (error.code === 11000 && error.keyPattern && error.keyPattern.email) {
      return res.status(400).json({ message: 'El correo ya está registrado.' });
    }
    console.error('Error al registrar usuario:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};


exports.login = async (req, res) => {
  try {
    const { username, password } = req.body;
    // Permite login por username o email
    const user = await User.findOne({
      $or: [{ username }, { email: username }]
    });
    if (!user) return res.status(400).json({ message: 'Invalid credentials' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Invalid password' });
    }

    const token = jwt.sign(
      { id: user._id, username: user.username },
      process.env.JWT_SECRET,
      { expiresIn: '2h' }
    );
    res.status(200).json({ token, username: user.username});
  } catch (err) {
    res.status(500).json({ message: 'Server error' });
  }
};


exports.checkUserExists = async (req, res) => {
  const { email, username } = req.body;
  try {
    const userByUsername = await User.findOne({ username });
    const userByEmail = await User.findOne({ email });

    let fields = [];
    let messages = {};

    if (userByUsername) {
      fields.push('username');
      messages.username = 'El nombre de usuario ya está en uso';
    }
    if (userByEmail) {
      fields.push('email');
      messages.email = 'El correo ya está en uso';
    }

    if (fields.length > 0) {
      return res.status(200).json({
        exists: true,
        fields,
        messages
      });
    }

    return res.status(200).json({ exists: false });
  } catch (error) {
    console.error('Error checking user existence:', error);
    res.status(500).json({ message: 'Server error' });
  }
};

exports.getUserProfile = async (req, res) => {
  try {
    const userId = req.user._id; // O req.query.userId si usas query
    const user = await User.findById(userId)
      .populate('equipo', 'name image slogan') // Popula el equipo con campos específicos
      .select('-password'); // Excluye la contraseña del resultado

    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    res.status(200).json(user);
  } catch (error) {
    console.error('Error al obtener perfil de usuario:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

exports.updateUserProfile = async (req, res) => {
  try {
    const userId = req.user._id; // O req.query.userId si usas query
    const updates = req.body;

    const user = await User.findByIdAndUpdate(userId, updates, { new: true })
      .populate('equipo', 'name image slogan') // Popula el equipo con campos específicos
      .select('-password'); // Excluye la contraseña del resultado
    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }
    res.status(200).json(user);
  } catch (error) {
    console.error('Error al actualizar perfil de usuario:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

exports.deleteUserProfile = async (req, res) => {
  try {
    const userId = req.user._id; // O req.query.userId si usas query

    const user = await User.findByIdAndDelete(userId);
    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    res.status(200).json({ message: 'Perfil de usuario eliminado con éxito' });
  } catch (error) {
    console.error('Error al eliminar perfil de usuario:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

exports.confirmEmail = async (req, res) => {
  const { token } = req.params;
  try {
    const user = await User.findOne({ tokenConfirm: token });
    if (!user) {
      return res.status(400).send(`<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Token inválido</title>
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', sans-serif;
      text-align: center;
      padding-top: 80px;
    }
    .container {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      display: inline-block;
      padding: 40px 60px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    h1 {
      color: #dc3545;
      font-size: 28px;
      margin-bottom: 20px;
    }
    p {
      font-size: 18px;
      color: #555;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>❌ Token de confirmación inválido</h1>
    <p>El enlace que usaste no es válido o ya ha sido utilizado.</p>
    <p>Si crees que esto es un error, por favor solicita un nuevo correo de confirmación.</p>
  </div>
</body>
</html>

        `);
    }
    user.status = 'VERIFIED';
    user.tokenConfirm = undefined;
    await user.save();
    return res.status(200).send(`
        <html>
          <head><title>Confirmación</title></head>
          <body style="font-family: sans-serif; text-align: center; margin-top: 50px;">
            <h1>✅ Correo validado con éxito</h1>
            <p>Gracias por confirmar tu cuenta en <strong>Esportify</strong>.</p>
          </body>
        </html>
      `);

  } catch (error) {
    console.error('Error al confirmar el correo:', error);
    return res.status(500).send(`<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Error del servidor</title>
  <style>
    body {
      background-color: #fff3f3;
      font-family: 'Segoe UI', sans-serif;
      text-align: center;
      padding-top: 80px;
    }
    .container {
      background-color: #ffffff;
      border: 1px solid #f5c2c7;
      border-radius: 8px;
      display: inline-block;
      padding: 40px 60px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    h1 {
      color: #dc3545;
      font-size: 28px;
      margin-bottom: 20px;
    }
    p {
      font-size: 18px;
      color: #6c757d;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>⚠️ Error interno del servidor</h1>
    <p>Ocurrió un problema al confirmar tu correo electrónico.</p>
    <p>Por favor, intenta nuevamente más tarde o contacta al soporte técnico.</p>
  </div>
</body>
</html>    
      `)
  }
};

exports.sendResetCode = async (req, res) => {
  const { email } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ message: 'Usuario no encontrado' });

    const code = crypto.randomBytes(2).toString('hex').toUpperCase(); // Ej: 'A1B2C3'
    user.resetCode = code;
    user.resetCodeExpires = Date.now() + 10 * 60 * 1000; // 10 minutos
    await user.save();
    const emailTemplate = `
      <p>Tu código para recuperar la contraseña es: <strong>${code}</strong></p>
      <p>Este código es válido por 10 minutos.</p>
    `;
    await sendEmail(email, 'Código de recuperación', emailTemplate);

    res.status(200).json({ message: 'Código enviado al correo' });
  } catch (error) {
    console.error('Error al enviar código:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

exports.validateResetCode = async (req, res) => {
  const { email, code } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    const isCodeValid = user.resetCode === code && Date.now() < user.resetCodeExpires;

    if (!isCodeValid) {
      return res.status(400).json({ message: 'Código inválido o expirado' });
    }

    res.status(200).json({ message: 'Código válido' });
  } catch (error) {
    console.error('Error al validar código:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
};

exports.changePassword = async (req, res) => {
  const { email, newPassword } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {  
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    user.password = hashedPassword;

    await user.save();
    res.status(200).json({ message: 'Contraseña cambiada' });
  } catch (error) {
    console.error('Error al cambiar la contraseña:', error);
    return res.status(500).json({ message: 'Error interno del servidor' });
  }
}; 

// buscar usuarios por nombre de usuario
exports.searchUsers = async (req, res) => {
  const { username } = req.query; // Obtener el nombre de usuario desde los parámetros de consulta
  try {
    const users = await User.find({
      username: { $regex: username, $options: 'i' } // Búsqueda insensible a mayúsculas/minúsculas
    }).select('username name email'); // Seleccionar solo campos específicos para devolver  
    res.status(200).json(users);
    
  } catch (error) {
    console.error('Error al buscar usuarios:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  } 
};