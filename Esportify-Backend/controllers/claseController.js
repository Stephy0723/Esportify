// const Clase = require('../models/Clase');

// const claseController = {
//     // Crear una nueva clase
//     createClase: async (req, res) => {
//         try {
//             const { nombre, descripcion, categoria, contenido } = req.body;

//             const nuevaClase = new Clase({
//                 nombre,
//                 descripcion,
//                 categoria,
//                 contenido
//             });

//             await nuevaClase.save();
//             res.status(201).json(nuevaClase);
//         } catch (err) {
//             console.error('Error creating class:', err);
//             res.status(500).json({ message: 'Internal server error' });
//         }
//     },

//     // Obtener todas las clases
//     getClases: async (req, res) => {
//         try {
//             const clases = await Clase.find();
//             res.status(200).json(clases);
//         } catch (err) {
//             console.error('Error fetching classes:', err);
//             res.status(500).json({ message: 'Internal server error' });
//         }
//     },

//     registerClase: async (req, res) => {
//         try {
//            const userId = req.user.id;
//            const claseId = req.params.id;

//             // Find the user and the class
//             const user = await User.findById(userId);
//             const clase = await Clase.findById(claseId);

//             if (!user || !clase) {
//                 return res.status(404).json({ message: 'User or class not found' });
//             }

//             // Check if the user is already registered in the class
//             if (user.clasesRegistradas.includes(claseId)) {
//                 return res.status(400).json({ message: 'User already registered in this class' });
//             }

//             // Register the user in the class
//             user.clasesRegistradas.push(claseId);
//             await user.save();

//             res.status(200).json({ message: 'User registered in class successfully' });
//         } catch (err) {
//             console.error('Error registering user in class:', err);
//             res.status(500).json({ message: 'Internal server error' });
//         }
//     }
// };

// module.exports = claseController;
