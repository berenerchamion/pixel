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
  LatLng _pickedPixelPlace = LatLng(0.0000, 0.0000);

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPixelPlace = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Your Location'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(
                Icons.check,
              ),
              onPressed: _pickedPixelPlace.latitude == 0.0 &&
                      _pickedPixelPlace.longitude == 0.0
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPixelPlace);
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
        markers: _pickedPixelPlace.latitude != 0.0 &&
                _pickedPixelPlace.latitude != 0.0
            ? {
                Marker(
                  position: _pickedPixelPlace,
                  markerId: MarkerId('m1'),
                ),
              }
            : {},
      ),
    );
  }
}
