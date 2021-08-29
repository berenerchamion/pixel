import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

import '../models/place.dart';
import '../models/pixel_location.dart';

class PixelPlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPixelPlace(
      String title, XFile image, PixelLocation location) async {
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
      'image': image.path,
      'loc_lat': newPixelPlace.location.latitude,
      'loc_lng': newPixelPlace.location.longitude,
      'loc_address': newPixelPlace.location.address
    });
  }

  Future<void> getPixelPlaces() async {
    final data = await DBHelper.getData('user_places');
    _places = data
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: PixelLocation(
              latitude: place['loc_lat'],
              longitude: place['loc_lng'],
              address: place['loc_address'],
            ),
            image: XFile(place['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
