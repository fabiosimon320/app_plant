import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Plant {
  final String name;
  final String scientificname;
  final ImageProvider image;
  final String description;
  final String id;

   Plant({
    String? id,
    required this.name,
    required this.scientificname,
    required this.image,
    required this.description,
  }) : id = id ?? Uuid().v4();
}