// lib//_step_one.dart
import 'package:esportefy/data/connect_to_backend.dart';
import 'package:flutter/material.dart';
import '../data/countries.dart'; // Lista de países latinoamericanos
import '../data/provinces.dart'; // Mapa país → provincias
import 'register_step_two.dart'; // Debe existir este archivo

class StepOne extends StatefulWidget {
  const StepOne({super.key, required this.userData});

  final Map<String, String?> userData;

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fechaController = TextEditingController();

  // Campos
  String usuario = '';
  String nombreReal = '';
  String correo = '';
  String contrasena = '';
  DateTime? fechaNacimiento;
  String genero = 'Masculino';
  String paisSeleccionado = '';
  String provinciaSeleccionada = '';
  String? _usuarioError;
  String? _correoError;

  @override
  void dispose() {
    _fechaController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final ahora = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: ahora.subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: ahora,
      locale: const Locale('es', 'ES'),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            onPrimary: Colors.black,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
          dialogTheme: DialogThemeData(backgroundColor: Colors.white),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        fechaNacimiento = picked;
        _fechaController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  void _onSiguiente() async {
    // Limpia errores anteriores
    setState(() {
      _usuarioError = null;
      _correoError = null;
    });

    // Valida localmente primero
    if (!_formKey.currentState!.validate()) return;

    // Guarda los valores de los campos
    _formKey.currentState!.save();

    try {
      // Llama al backend para verificar usuario y correo
      final result = await ApiService.checkUsernameAvailability(
        usuario,
        correo,
      );

      if (result['exists'] == true) {
        setState(() {
          if (result['fields'] != null) {
            if (result['fields'].contains('username')) {
              _usuarioError = result['messages']['username'];
            }
            if (result['fields'].contains('email')) {
              _correoError = result['messages']['email'];
            }
          } else if (result['field'] == 'username') {
            _usuarioError =
                result['message'] ?? 'El nombre de usuario ya está en uso';
          } else if (result['field'] == 'email') {
            _correoError = result['message'] ?? 'El correo ya está en uso';
          }
        });
        Future.microtask(() => _formKey.currentState!.validate());
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error de conexión: $e')));
      return;
    }

    // Si todo está bien, avanza
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.check, size: 48, color: Colors.green),
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Listo!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Paso 1 completado.\nLos datos se guardaron correctamente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterStepTwo(
                          userData: {
                            'username': usuario,
                            'name': nombreReal,
                            'email': correo,
                            'password': contrasena,
                            'fechaNacimiento': fechaNacimiento
                                ?.toIso8601String(),
                            'genero': genero,
                            'pais': paisSeleccionado,
                            'provincia': provinciaSeleccionada,
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                  ),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provincias = paisSeleccionado.isEmpty
        ? const <String>[]
        : countryToProvinces[paisSeleccionado] ?? const <String>[];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      'Esportify',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Información básica',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Usuario
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'Nombre de usuario',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      errorText: _usuarioError,
                    ),
                    validator: (v) {
                      if (_usuarioError != null) return _usuarioError;
                      if (v == null || v.trim().isEmpty) return 'Requerido';
                      return null;
                    },
                    onSaved: (v) => usuario = v!.trim(),
                  ),
                  const SizedBox(height: 16),

                  // Nombre real
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_box),
                      hintText: 'Nombre real',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Requerido' : null,
                    onSaved: (v) => nombreReal = v!.trim(),
                  ),
                  const SizedBox(height: 16),

                  // Correo
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Correo electrónico',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      errorText: _correoError,
                    ),
                    validator: (v) {
                      if (_correoError != null) return _correoError;
                      if (v == null || v.trim().isEmpty) return 'Requerido';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                        return 'Correo inválido';
                      }
                      return null;
                    },
                    onSaved: (v) => correo = v!.trim(),
                  ),
                  const SizedBox(height: 16),

                  // Contraseña
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Requerido';
                      if (v.length < 6) {
                        return 'Debe tener al menos 6 caracteres';
                      }
                      if (v.length > 20) {
                        return 'Debe tener como máximo 20 caracteres';
                      }
                      return null;
                    },
                    onSaved: (v) => contrasena = v!,
                  ),
                  const SizedBox(height: 16),

                  // Fecha nacimiento
                  GestureDetector(
                    onTap: () => _seleccionarFecha(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _fechaController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          hintText: 'Fecha de nacimiento',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (v) =>
                            fechaNacimiento == null ? 'Requerido' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Género
                  DropdownButtonFormField<String>(
                    value: genero,
                    dropdownColor: Colors.grey[200],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.transgender),
                      hintText: 'Género',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Masculino',
                        child: Text('Masculino'),
                      ),
                      DropdownMenuItem(
                        value: 'Femenino',
                        child: Text('Femenino'),
                      ),
                      DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                    ],
                    onChanged: (v) => setState(() => genero = v!),
                  ),
                  const SizedBox(height: 16),

                  // País
                  Autocomplete<String>(
                    optionsBuilder: (te) {
                      if (te.text.isEmpty) return const <String>[];
                      return latinAmericanCountries.where(
                        (p) => p.toLowerCase().contains(te.text.toLowerCase()),
                      );
                    },
                    onSelected: (sel) => setState(() {
                      paisSeleccionado = sel;
                      provinciaSeleccionada = '';
                    }),
                    fieldViewBuilder: (ctx, ctrl, fn, onEdit) => TextFormField(
                      controller: ctrl,
                      focusNode: fn,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.public),
                        hintText: 'País',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onEditingComplete: onEdit,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Requerido' : null,
                    ),
                    optionsViewBuilder: (ctx, onSel, opts) {
                      final list = opts.toList();
                      final h = (list.length * 48)
                          .clamp(48.0, 48.0 * 6)
                          .toDouble();
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: Colors.white,
                          elevation: 4,
                          child: SizedBox(
                            width: MediaQuery.of(ctx).size.width - 48,
                            height: h,
                            child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (_, i) => InkWell(
                                onTap: () => onSel(list[i]),
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(list[i]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Provincia
                  Autocomplete<String>(
                    optionsBuilder: (te) {
                      if (paisSeleccionado.isEmpty || te.text.isEmpty) {
                        return const <String>[];
                      }
                      return (countryToProvinces[paisSeleccionado] ?? []).where(
                        (s) => s.toLowerCase().contains(te.text.toLowerCase()),
                      );
                    },
                    onSelected: (sel) => provinciaSeleccionada = sel,
                    fieldViewBuilder: (ctx, ctrl, fn, onEdit) => TextFormField(
                      controller: ctrl,
                      focusNode: fn,
                      enabled: paisSeleccionado.isNotEmpty,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.map),
                        hintText: 'Provincia / Estado',
                        filled: true,
                        fillColor: paisSeleccionado.isEmpty
                            ? Colors.grey[50]
                            : Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onEditingComplete: onEdit,
                      validator: (v) {
                        if (paisSeleccionado.isNotEmpty &&
                            (v == null || v.trim().isEmpty)) {
                          return 'Requerido';
                        }
                        return null;
                      },
                    ),
                    optionsViewBuilder: (ctx, onSel, opts) {
                      final list = opts.toList();
                      final h = (list.length * 48)
                          .clamp(48.0, 48.0 * 6)
                          .toDouble();
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: Colors.white,
                          elevation: 4,
                          child: SizedBox(
                            width: MediaQuery.of(ctx).size.width - 48,
                            height: h,
                            child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (_, i) => InkWell(
                                onTap: () => onSel(list[i]),
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(list[i]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Botón Siguiente
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _onSiguiente,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Siguiente',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
