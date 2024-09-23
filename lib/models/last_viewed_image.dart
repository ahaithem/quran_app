import 'package:isar/isar.dart';

part 'last_viewed_image.g.dart'; // This will be generated

@Collection()
class LastViewedImage {
  Id id = Isar.autoIncrement; // Unique ID for each entry
  int index = 0; // To store the last viewed image index
}
