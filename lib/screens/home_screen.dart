// import 'package:flutter/material.dart';
// import '../services/quran_service.dart';
// import '../models/verse.dart';
// import 'surah_detail_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Future<List<Verse>> _quranData;
//   final QuranService _quranService = QuranService();

//   @override
//   void initState() {
//     super.initState();
//     _quranData = _quranService.loadQuranData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quran Karim'),
//         backgroundColor: Colors.green, // Custom color for AppBar
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: FutureBuilder<List<Verse>>(
//                 future: _quranData,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error loading Quran data'));
//                   }

//                   final List<Verse> verses = snapshot.data ?? [];

//                   // Group verses by Surah number
//                   Map<int, List<Verse>> surahMap = {};
//                   for (var verse in verses) {
//                     if (!surahMap.containsKey(verse.suraNo)) {
//                       surahMap[verse.suraNo] = [];
//                     }
//                     surahMap[verse.suraNo]!.add(verse);
//                   }

//                   return ListView.separated(
//                     itemCount: surahMap.keys.length,
//                     separatorBuilder: (context, index) =>
//                         Divider(height: 1.0, color: Colors.grey[300]),
//                     itemBuilder: (context, index) {
//                       final surahNo = surahMap.keys.elementAt(index);
//                       final List<Verse> surahVerses = surahMap[surahNo]!;
//                       final String surahNameAr = surahVerses[0]
//                           .suraNameAr; // All verses in the same Surah have the same name

//                       return ListTile(
//                         contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8.0),
//                         tileColor:
//                             Colors.grey[200], // Background color of the tile
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Rounded corners
//                         ),
//                         leading: Icon(
//                           Icons.book, // Leading icon
//                           color: Colors.blue,
//                         ),
//                         title: Text(
//                           '$surahNo سورة $surahNameAr',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18.0,
//                             color: Colors.black87, // Text color
//                           ),
//                         ),
//                         onTap: () {
//                           Navigator.pop(context); // Close the Drawer
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   SurahDetailScreen(verses: surahVerses),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Text(
//           'Select a Surah from the Drawer',
//           style: TextStyle(
//             fontSize: 18.0,
//             color: Colors.black54,
//           ),
//         ),
//       ),
//     );
//   }
// }
