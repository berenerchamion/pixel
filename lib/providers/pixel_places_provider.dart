import 'package:flutter/material.dart';

import '../models/place.dart';

class PixelPlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }
}
