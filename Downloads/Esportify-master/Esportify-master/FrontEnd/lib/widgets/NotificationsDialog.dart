import 'package:flutter/material.dart';

class NotificationsDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black87,
        insetPadding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Novedades',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Colors.white54),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      'Aquí irán todas las novedades importantes para el usuario.\n\n'
                          '- Nueva actualización disponible.\n'
                          '- Torneos próximos.\n'
                          '- Mensajes sin leer.\n'
                          '- Eventos especiales.',
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
