import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  // Coordinates for Makkah Al-Mukarramah
  final Coordinates coordinates = const Coordinates(21.4225, 39.8262);
  late CalculationParameters params;
  late PrayerTimes prayerTimes;

  @override
  void initState() {
    super.initState();
    params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(coordinates, params);
  }

  @override
  Widget build(BuildContext context) {
    final nextPrayer = prayerTimes.nextPrayer();
    final nextTime = prayerTimes.timeForPrayer(nextPrayer);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('نور الهدى - Noor Al-Huda'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/mosque_hero.jpg', fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildNextPrayerCard(nextPrayer.name, nextTime),
                  const SizedBox(height: 16),
                  _buildPrayerSchedule(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextPrayerCard(String name, DateTime? time) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Next Prayer', style: TextStyle(color: Colors.grey)),
                Text(name.toUpperCase(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            Text(
              time != null ? DateFormat.jm().format(time) : '--:--',
              style: const TextStyle(fontSize: 22, color: Color(0xFF10B981), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerSchedule() {
    final list = [
      {'name': 'Fajr', 'ar': 'الفجر', 'time': prayerTimes.fajr},
      {'name': 'Sunrise', 'ar': 'الشروق', 'time': prayerTimes.sunrise},
      {'name': 'Dhuhr', 'ar': 'الظهر', 'time': prayerTimes.dhuhr},
      {'name': 'Asr', 'ar': 'العصر', 'time': prayerTimes.asr},
      {'name': 'Maghrib', 'ar': 'المغرب', 'time': prayerTimes.maghrib},
      {'name': 'Isha', 'ar': 'العشاء', 'time': prayerTimes.isha},
    ];

    return Column(
      children: list.map((item) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.access_time_rounded, color: Color(0xFFD97706)),
            title: Text(item['name'] as String),
            subtitle: Text(item['ar'] as String, style: const TextStyle(fontFamily: 'Amiri')),
            trailing: Text(DateFormat.jm().format(item['time'] as DateTime)),
          ),
        );
      }).toList(),
    );
  }
}
