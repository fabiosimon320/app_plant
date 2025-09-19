import 'package:flutter/cupertino.dart';

class Plant {
  final String name;
  final ImageProvider image;
  final String description;

  const Plant({
    required this.name,
    required this.image,
    required this.description,
  });
}