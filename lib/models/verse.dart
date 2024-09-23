// import 'package:flutter/material.dart';
// import 'surah_detail_screen.dart';
// import '../models/all_surahs.dart';

// class SurahListScreen extends StatefulWidget {
//   @override
//   _SurahListScreenState createState() => _SurahListScreenState();
// }

// class _SurahListScreenState extends State<SurahListScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final surahNames = surahPages.keys.toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quran Karim'),
//         backgroundColor: Colors.teal,
//       ),
//       body: ListView.builder(
//         itemCount: surahPages.length,
//         itemBuilder: (context, index) {
//           String surahName = surahNames[index];
//           return FadeTransition(
//             opacity: _animation,
//             child: Card(
//               margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.book,
//                   color: Colors.teal,
//                 ),
//                 title: Text(
//                   surahName,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18.0,
//                   ),
//                 ),
//                 subtitle: Text(
//                   'Starting Page: ${surahPages[surahName]}',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                 onTap: () {
//                   int startingPage = surahPages[surahName] ?? 1;
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SurahDetailScreen(
//                         startingImageIndex: startingPage,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
