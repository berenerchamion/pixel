import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:path/path.dart' as p;

import '../models/place.dart';
import '../models/pixel_location.dart';

class PixelPlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPixelPlace(String title, XFile image) {
    //How to convert an XFile to an image - remove later if not needed
    // Image? pixelImage = Image.file(File(image.path));

    PixelLocation location = PixelLocation(
      latitude: 0.0,
      longitude: 0.0,
      address: 'House of Beor, llc.',
    );

    final newPixelPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: location,
    );

    _places.add(newPixelPlace);
    print('Adding place length= ${_places.length}');
    notifyListeners();
  }
}
