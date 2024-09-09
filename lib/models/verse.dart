// models/verse.dart

class Verse {
  final int id;
  final int jozz;
  final int suraNo;
  final String suraNameEn;
  final String suraNameAr;
  final int page;
  final int lineStart;
  final int lineEnd;
  final int ayaNo;
  final String ayaTextEmlaey;

  Verse({
    required this.id,
    required this.jozz,
    required this.suraNo,
    required this.suraNameEn,
    required this.suraNameAr,
    required this.page,
    required this.lineStart,
    required this.lineEnd,
    required this.ayaNo,
    required this.ayaTextEmlaey,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'],
      jozz: json['jozz'],
      suraNo: json['sura_no'],
      suraNameEn: json['sura_name_en'],
      suraNameAr: json['sura_name_ar'],
      page: json['page'],
      lineStart: json['line_start'],
      lineEnd: json['line_end'],
      ayaNo: json['aya_no'],
      ayaTextEmlaey:
          json['aya_text_emlaey'], // Only using aya_text_emlaey as requested
    );
  }
}
