import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:io';

import './add_place_screen.dart';
import '../providers/pixel_places_provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places My Pixel Has Been'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<PixelPlacesProvider>(
          child: Center(
            child: Text('You need to add some places.'),
          ),
          builder: (ctx, pixelPlacesProvider, ch) {
            if (pixelPlacesProvider.places.length > 0) {
              print('WTF: ${pixelPlacesProvider.places.length}');
              return ListView.builder(
                  itemCount: pixelPlacesProvider.places.length,
                  itemBuilder: (ctx, int i) {
                    return ListTile(
                      leading: CircleAvatar(
                        // Image? pixelImage = Image.file(File(image.path));
                        backgroundImage: FileImage(
                            File(pixelPlacesProvider.places[i].image.path)),
                      ),
                      title: Text(pixelPlacesProvider.places[i].title),
                      onTap: (){},
                    );
                  });
            } else {
              return Center(
                child: Text(
                    'You need to add some places: ${pixelPlacesProvider.places.length}'),
              );
            }
            return Text('Still no list: ${pixelPlacesProvider.places.length}');
          }), //Consumer
    );
  }
}
