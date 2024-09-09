import 'package:flutter/material.dart';
import '../models/verse.dart';

class SurahDetailScreen extends StatelessWidget {
  final List<Verse> verses;

  SurahDetailScreen({required this.verses});

  @override
  Widget build(BuildContext context) {
    // Combine all verses into a single string with line breaks
    final String combinedVerses = verses.map((verse) {
      return ' ${verse.ayaTextEmlaey} ${verse.ayaNo}';
    }).join('');

    return Scaffold(
      appBar: AppBar(
        title: Text('Surah ${verses[0].suraNameAr}'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            combinedVerses,
            style: TextStyle(fontSize: 22.0),
          ),
        ),
      ),
    );
  }
}
