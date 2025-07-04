const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

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

    const newUser = new User({
      username,
      name,
      email,
      password: hashedPassword,
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

    await newUser.save();

    const token = jwt.sign({ id: newUser._id, username: newUser.username }, process.env.JWT_SECRET, {
      expiresIn: '2h'
    });

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
    res.status(200).json({ token, userId: user._id });
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

// 🚀 NUEVO MÉTODO: Obtener datos del usuario por ID
exports.getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id).select('-password');
    if (!user) return res.status(404).json({ message: 'Usuario no encontrado' });
    res.status(200).json(user);
  } catch (err) {
    console.error('Error al buscar usuario:', err);
    res.status(500).json({ message: 'Error del servidor' });
  }
};
