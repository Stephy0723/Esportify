// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'WelcomeScreen.dart'; // o donde tengas tu RegisterStepOne

void main() {
  runApp(const EsportefyApp());
}

class EsportefyApp extends StatelessWidget {
  const EsportefyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esportefy',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // Español
        Locale('en', 'US'), // Inglés
      ],

      // ───────────────────────────────────────────────────────────────
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF2F2F2)),

      home: const WelcomeScreen(),
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF2F2F2)),
      home: const HomePage(), // <- Aquí se inicia ahora
    );
  }
}
