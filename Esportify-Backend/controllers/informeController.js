// const Informe = require('../models/Informe');

// exports.createInforme = async (req, res) => {
//     try {
//         const {estudianteId, claseId, observaciones, avance} = req.body;
//         const newInforme = new Informe({
//             estudianteId,
//             claseId,
//             observaciones,
//             avance,
//             mentorId: req.user.id,
//             fecha: new Date(),
//         });
//         await newInforme.save();
//         res.status(201).json(newInforme);
//     } catch (error) {
//         res.status(500).json({ message: 'Server error' });
//     };

//     exports.getInformesPorEstudiante = async (req, res) => {
//         try {
//             const estudianteId = req.params.id;
//             const informes = await Informe.find({ estudianteId }).populate('mentorId', 'name email').populate('claseId', 'nombre categoria');
//             if (informes.length === 0) return res.status(404).json({ message: 'No reports found for this student' });
//             res.status(200).json(informes);
//         } catch (error) {
//             res.status(500).json({ message: 'Server error' });
//         }
//     };
    
// };
