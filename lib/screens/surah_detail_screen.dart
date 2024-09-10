import 'package:flutter/material.dart';
import '../models/verse.dart';

class SurahDetailScreen extends StatelessWidget {
  final List<Verse> verses;
  final int currentSurahNo;
  final void Function(int surahNo) onNavigateToSurah;
  final VoidCallback onHomePressed; // Callback to handle home navigation

  SurahDetailScreen({
    required this.verses,
    required this.currentSurahNo,
    required this.onNavigateToSurah,
    required this.onHomePressed, // Initialize the home callback
  });

  @override
  Widget build(BuildContext context) {
    // Combine all verses into a single string with line breaks
    final String combinedVerses = verses.map((verse) {
      return ' ${verse.ayaTextEmlaey} ${verse.ayaNo}';
    }).join('\n');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Do not automatically imply a leading button
        title: Row(
          children: [
            // Home button
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                onHomePressed(); // Navigate to the first screen
              },
            ),
            // Surah name
            Expanded(
              child: Center(
                child: Text('Surah ${verses[0].suraNameAr}'),
              ),
            ),
            // Previous button
            if (currentSurahNo > 1)
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _navigateToSurah(
                      context, currentSurahNo - 1); // Go to previous Surah
                },
              ),
            // Next button
            if (currentSurahNo < 114)
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  _navigateToSurah(
                      context, currentSurahNo + 1); // Go to next Surah
                },
              ),
          ],
        ),
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

  void _navigateToSurah(BuildContext context, int surahNo) {
    if (surahNo > 0 && surahNo <= 114) {
      // Ensure the Surah number is valid
      onNavigateToSurah(surahNo);
    }
  }
}
