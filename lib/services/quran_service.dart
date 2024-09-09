// services/quran_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/verse.dart';

class QuranService {
  Future<List<Verse>> loadQuranData() async {
    try {
      // Load the JSON file
      final String response = await rootBundle.loadString('assets/quran.json');

      // Decode the JSON
      final List<dynamic> data = json.decode(response);

      // Convert each item in the list into a Verse object
      return data.map((verseJson) => Verse.fromJson(verseJson)).toList();
    } catch (e) {
      print("Error loading Quran data: $e");
      throw Exception("Error loading Quran data");
    }
  }
}
