import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'page/home_page.dart';

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
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),

      // ─── Soporte de idiomas ───
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],

      // ─── Página de inicio ───
      home: const HomePage(),
    );
  }
}
