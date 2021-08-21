import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import '../helpers/db_helper.dart';

import '../models/place.dart';
import '../models/pixel_location.dart';

class PixelPlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPixelPlace(String title, XFile image) {
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
    DBHelper.insert('user_places', {
      'id': newPixelPlace.id,
      'title': newPixelPlace.title,
      'image': image.path
    });
  }

  Future<void> getPixelPlaces() async {
    final data = await DBHelper.getData('user_places');
    _places = data
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: PixelLocation(latitude: 0.0, longitude: 0.0),
            image: XFile(place['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
