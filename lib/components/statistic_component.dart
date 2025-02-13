import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.50,
    color: Colors.black,
  );

  static const TextStyle _statValueStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.27,
    color: Colors.black,
  );

  static const TextStyle _subtitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.40,
    color: Colors.black54,
  );

  final String title;
  final String statValue;
  final String subtitle;
  final IconData icon;

  const StatsCard({
    super.key,
    required this.title,
    required this.statValue,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: _titleStyle),
                const SizedBox(height: 5),
                Text(statValue, style: _statValueStyle),
                Text(subtitle, style: _subtitleStyle),
              ],
            ),
            SizedBox(
              width: 16,
              height: 16,
              child: Icon(
                icon,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}