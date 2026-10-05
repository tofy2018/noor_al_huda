import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  double? _direction;
  final double _qiblaBearing = 118.0; // Bearing to Makkah

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((event) {
      if (mounted) {
        setState(() {
          _direction = event.heading;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double heading = _direction ?? 0;
    final double angleDiff = (_qiblaBearing - heading).abs() % 360;
    final bool isAligned = angleDiff < 3 || angleDiff > 357;

    return Scaffold(
      appBar: AppBar(title: const Text('اتجاه القبلة - Qibla Compass')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: (heading * (math.pi / 180) * -1),
              child: Image.asset('assets/images/compass_rose.png', width: 280),
            ),
            const SizedBox(height: 24),
            Text(
              isAligned ? 'Aligned with Qibla!' : '${heading.toStringAsFixed(0)}°',
              style: TextStyle(
                fontSize: 20,
                color: isAligned ? const Color(0xFF10B981) : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
