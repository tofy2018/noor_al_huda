import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _count = 0;
  int _target = 33;
  String _selectedDhikr = 'سُبْحَانَ اللَّهِ';

  void _increment() {
    HapticFeedback.lightImpact();
    setState(() {
      _count++;
      if (_count % _target == 0) {
        Vibration.vibrate(duration: 100);
      }
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('السبحة الإلكترونية')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_selectedDhikr, style: const TextStyle(fontSize: 28, fontFamily: 'Amiri')),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: _increment,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [Color(0xFF059669), Color(0xFF064E3B)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF059669).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$_count',
                    style: const TextStyle(fontSize: 54, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _reset,
              tooltip: 'Reset Counter',
            ),
          ],
        ),
      ),
    );
  }
}
