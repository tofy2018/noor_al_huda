import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  runApp(const NoorAlHudaApp());
}

class NoorAlHudaApp extends StatefulWidget {
  const NoorAlHudaApp({super.key});

  @override
  State<NoorAlHudaApp> createState() => _NoorAlHudaAppState();
}

class _NoorAlHudaAppState extends State<NoorAlHudaApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('ar');

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noor Al-Huda (نور الهدى)',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: _locale,
      home: HomeScreen(
        onToggleTheme: toggleTheme,
        onToggleLocale: toggleLocale,
      ),
    );
  }
}
