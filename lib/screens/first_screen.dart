import 'package:flutter/material.dart';
import '../services/quran_service.dart';
import '../models/verse.dart';
import 'surah_detail_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Future<List<Verse>> _quranData;
  final QuranService _quranService = QuranService();
  Map<int, List<Verse>> surahMap = {};

  @override
  void initState() {
    super.initState();
    _quranData = _quranService.loadQuranData();
  }

  void _navigateToSurah(int surahNo) {
    final verses = surahMap[surahNo];
    if (verses != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurahDetailScreen(
            verses: verses,
            currentSurahNo: surahNo,
            onNavigateToSurah: _navigateToSurah,
            onHomePressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Karim'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Verse>>(
        future: _quranData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading Quran data'));
          }

          final List<Verse> verses = snapshot.data ?? [];
          // Group verses by Surah number
          surahMap = {};
          for (var verse in verses) {
            if (!surahMap.containsKey(verse.suraNo)) {
              surahMap[verse.suraNo] = [];
            }
            surahMap[verse.suraNo]!.add(verse);
          }

          return ListView.separated(
            itemCount: surahMap.keys.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1.0, color: Colors.grey[300]),
            itemBuilder: (context, index) {
              final surahNo = surahMap.keys.elementAt(index);
              final List<Verse> surahVerses = surahMap[surahNo]!;
              final String surahNameAr = surahVerses[0].suraNameAr;

              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 50 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  tileColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  leading: Icon(
                    Icons.book,
                    color: Colors.blue,
                  ),
                  title: Text(
                    '$surahNo سورة $surahNameAr',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black87,
                    ),
                  ),
                  onTap: () => _navigateToSurah(surahNo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
