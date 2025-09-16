const User = require('../models/User');// Debes tener este modelo

exports.getMainPageData = async (req, res) => {
    try {
        const userId = req.user._id; // O req.query.userId si usas query

        // 1. Obtener usuario y sus juegos favoritos
        const user = await User.findById(userId);
        if (!user) return res.status(404).json({ message: 'Usuario no encontrado' });

        // 2. Torneos disponibles relacionados a sus juegos favoritos
        const tournaments = await Tournament.find({
            juego: { $in: user.juegosFavoritos }
        });

        // 3. Comunidades (equipos) de sus juegos favoritos
        const communities = await Team.find({
            juegos: { $in: user.juegosFavoritos }
        });

        res.json({
            tournaments,
            juegosFavoritos: user.juegosFavoritos,
            communities
        });
    } catch (error) {
        res.status(500).json({ message: 'Error al cargar la página principal' });
    }
};