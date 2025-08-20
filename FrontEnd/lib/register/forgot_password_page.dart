import 'package:esportefy/data/connect_to_backend.dart';
import 'package:flutter/material.dart';
import 'verify_email_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen personalizada
              Image.asset(
                'lib/assets/login/candado.gif',
                width: 160,
                height: 160,
              ),
              const SizedBox(height: 24),

              const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ingresa tu correo para recibir un código de verificación.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),

              const SizedBox(height: 32),

              // Campo de correo
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: 'Correo electrónico',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Botón enviar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black38,
                  ),
                  onPressed: () async {
                    
                    try {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyEmailPage(email: emailCtrl.text),
                      ),
                    );
                      await ApiService.sendResetCode(emailCtrl.text);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error al enviar el código: $e'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Enviar código',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Texto alternativo
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Probar otra forma",
                  style: TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.w500,
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
