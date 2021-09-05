import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:io';

import './add_place_screen.dart';
import '../providers/pixel_places_provider.dart';

import '../screens/place_detail_screen.dart';

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
      body: FutureBuilder(
        future: Provider.of<PixelPlacesProvider>(context, listen: false)
            .getPixelPlaces(),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PixelPlacesProvider>(
                child: Center(
                  child: Text('You need to add some places.'),
                ),
                builder: (ctx, pixelPlacesProvider, ch) {
                  if (pixelPlacesProvider.places.length > 0) {
                    return ListView.builder(
                        itemCount: pixelPlacesProvider.places.length,
                        itemBuilder: (ctx, int i) {
                          return ListTile(
                            leading: CircleAvatar(
                              // Image? pixelImage = Image.file(File(image.path));
                              backgroundImage: FileImage(File(
                                  pixelPlacesProvider.places[i].image.path)),
                            ),
                            title: Text(pixelPlacesProvider.places[i].title),
                            subtitle: Text(pixelPlacesProvider.places[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: pixelPlacesProvider.places[i].id,
                              );
                            },
                          );
                        });
                  } else {
                    return Center(
                      child: Text(
                          'You need to add some places: ${pixelPlacesProvider.places.length}'),
                    );
                  }
                }),
      ), //Consumer
    );
  }
}
