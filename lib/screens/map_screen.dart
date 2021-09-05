import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/pixel_location.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';

  final PixelLocation pixelLocation;
  final bool isSelecting;

  MapScreen(
      {this.pixelLocation = const PixelLocation(
        latitude: 40.2959472605,
        longitude: -75.0822173512,
      ),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng pickedPixelPlace;

  _MapScreenState({ this.pickedPixelPlace = const LatLng(0.0, 0.0),
  });

  void _selectLocation(LatLng position) {
    setState(() {
      pickedPixelPlace = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSelecting) {
      pickedPixelPlace = LatLng(widget.pixelLocation.latitude, widget.pixelLocation.longitude);
    }

    return Scaffold(
      appBar: AppBar(
        title: widget.isSelecting
            ? Text('Pick Your Location')
            : Text('Pixel Place Location'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(
                Icons.check,
              ),
              onPressed: pickedPixelPlace.latitude == 0.0 &&
                      pickedPixelPlace.longitude == 0.0
                  ? null
                  : () {
                      Navigator.of(context).pop(pickedPixelPlace);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.pixelLocation.latitude, widget.pixelLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: pickedPixelPlace.latitude != 0.0 &&
                pickedPixelPlace.latitude != 0.0 &&
                widget.isSelecting == false
            ? {
                Marker(
                  position: LatLng(widget.pixelLocation.latitude,
                      widget.pixelLocation.longitude),
                  markerId: MarkerId('m1'),
                ),
              }
            : {
                Marker(
                  position: pickedPixelPlace,
                  markerId: MarkerId('m1'),
                ),
              },
      ),
    );
  }
}
