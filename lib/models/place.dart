import 'package:flutter/foundation.dart';
import 'dart:io';

import './pixel_location.dart';

class Place{
  final String id;
  final String title;
  final PixelLocation location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}