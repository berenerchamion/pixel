import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import './pixel_location.dart';

class Place{
  final String id;
  final String title;
  final PixelLocation location;
  final XFile image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}