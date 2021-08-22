import 'package:flutter/foundation.dart';

class PixelLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PixelLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}
