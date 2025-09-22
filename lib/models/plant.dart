import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Plant {
  final String name;
  final String scientificname;
  final ImageProvider image;
  final String description;
  final String id;
  final int waterday;
  final String sunlight;
  final String soiltype;

   Plant({
    String? id,
    required this.name,
    required this.scientificname,
    required this.image,
    required this.description,
    required this.waterday,
    required this.sunlight,
    required this.soiltype,

  }) : id = id ?? Uuid().v4();
}