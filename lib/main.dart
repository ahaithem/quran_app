import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() {
  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Karim',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SurahListScreen(),
    );
  }
}
