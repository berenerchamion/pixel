import 'package:flutter/material.dart';
import 'package:pixel/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../providers/pixel_places_provider.dart';
import '../models/place.dart';
import '../screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/pixel-place-detail';

  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Object? id = ModalRoute.of(context)!.settings.arguments;
    if (id == null) {
      Navigator.of(context).pop();
    }
    print('id: ${id.toString()}');
    final Place place = Provider.of<PixelPlacesProvider>(context, listen: false)
        .findById(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Pixel Places - Details'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image(
              image: FileImage(File(
                  place.image.path)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(place.title),
          SizedBox(
            height: 10,
          ),
          TextButton(
            child: Text('View on Map'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    pixelLocation: place.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
