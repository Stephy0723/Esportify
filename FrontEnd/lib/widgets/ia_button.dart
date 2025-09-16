// lib/widgets/ia_button.dart
import 'package:flutter/material.dart';

class IAButton extends StatefulWidget {
  /// Acción a ejecutar al tocar el botón
  final VoidCallback onTap;
  const IAButton({super.key, required this.onTap});

  @override
  State<IAButton> createState() => _IAButtonState();
}

class _IAButtonState extends State<IAButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 24,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          transform: Matrix4.identity()..scale(_pressed ? 0.9 : 1.0),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.auto_awesome, // icono de estrellitas
              size: 32,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
