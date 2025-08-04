const jwt = require('jsonwebtoken');
const User = require('../models/User'); // ← Asegúrate de importar tu modelo User

const auth = async (req, res, next) => {
  const authHeader = req.header('Authorization');
  if (!authHeader) return res.status(401).json({ message: 'No token provided' });

  const token = authHeader.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Token mal formado' });

  try {
    const verified = jwt.verify(token, process.env.JWT_SECRET);

    // Aquí traes toda la info del usuario
    const user = await User.findById(verified.id);
    if (!user) return res.status(401).json({ message: 'Usuario no encontrado' });

    req.user = user; // Ahora req.user tiene todos los campos del esquema
    next();
  } catch (err) {
    console.error(err);
    res.status(401).json({ message: 'Token inválido' });
  }
};

module.exports = auth;
