// lib//_step_four.dart

import 'package:esportefy/data/connect_to_backend.dart';
import 'package:flutter/material.dart';
import '../LoginScreen.dart'; // Ajusta según tu ruta real

class StepFour extends StatefulWidget {
  const StepFour({super.key, required this.userData});
  final Map<String, String?> userData;

  @override
  State<StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<StepFour> {
  bool _selectAll = false;
  bool _acceptTerms = false;
  bool _acceptPrivacy = false;
  bool _wantsNotifications = false;
  bool _isLoading = false;

  void _recalcSelectAll() {
    _selectAll = _acceptTerms && _acceptPrivacy && _wantsNotifications;
  }

  void _onSelectAllChanged(bool? value) {
    final v = value ?? false;
    setState(() {
      _selectAll = v;
      _acceptTerms = v;
      _acceptPrivacy = v;
      _wantsNotifications = v;
    });
  }

  void _onTermsChanged(bool? value) {
    setState(() {
      _acceptTerms = value ?? false;
      _recalcSelectAll();
    });
  }

  void _onPrivacyChanged(bool? value) {
    setState(() {
      _acceptPrivacy = value ?? false;
      _recalcSelectAll();
    });
  }

  void _onNotificationsChanged(bool? value) {
    setState(() {
      _wantsNotifications = value ?? false;
      _recalcSelectAll();
    });
  }

  Widget _buildCheckbox(
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // El botón sólo está habilitado si términos y privacidad son true
    final canFinish = _acceptTerms && _acceptPrivacy;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '¡Bienvenido a Esportify!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Seleccionar todo
              _buildCheckbox(
                'Seleccionar todo',
                _selectAll,
                _onSelectAllChanged,
              ),
              const SizedBox(height: 16),

              // Términos y Condiciones
              _buildCheckbox(
                'He leído y acepto los Términos y Condiciones',
                _acceptTerms,
                _onTermsChanged,
              ),
              const SizedBox(height: 8),

              // Política de Privacidad
              _buildCheckbox(
                'He leído y acepto la Política de Privacidad',
                _acceptPrivacy,
                _onPrivacyChanged,
              ),
              const SizedBox(height: 8),

              // Notificaciones importantes (opcional)
              _buildCheckbox(
                'Deseo recibir notificaciones importantes',
                _wantsNotifications,
                _onNotificationsChanged,
              ),
              const SizedBox(height: 32),

              // Botón Finalizar registro o indicador de carga
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_acceptTerms || !_acceptPrivacy) return;

                          setState(() => _isLoading = true);

                          final userData = {
                            ...widget.userData,
                            'aceptaTerminos': _acceptTerms,
                            'aceptaPrivacidad': _acceptPrivacy,
                            'notificaciones': _wantsNotifications,
                          };

                          print('Datos enviados al backend: $userData');

                          try {
                            final response = await ApiService.registerUser(
                              userData,
                            );
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${response.body}'),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error de conexión: $e')),
                            );
                          } finally {
                            setState(() => _isLoading = false);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: canFinish
                              ? Colors.black
                              : Colors.white,
                          foregroundColor: canFinish
                              ? Colors.white
                              : Colors.black,
                          elevation: canFinish ? 4 : 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide.none, // Sin bordes siempre
                        ),
                        child: const Text(
                          'Finalizar registro',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
