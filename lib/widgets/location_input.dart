import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPixelPlace;

  const LocationInput(this.onSelectPixelPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';

  void _showPreview(double lat, double lng) {
    final staticPixelPlaceMapUrl = LocationHelper.generatePixelPlacePreview(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticPixelPlaceMapUrl;
    });
  }

  Future<void> _getPixelLocation() async {
    final locationData = await Location().getLocation();

    _showPreview(locationData.latitude!, locationData.longitude!);

    widget.onSelectPixelPlace(
      locationData.latitude,
      locationData.longitude,
    );
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(isSelecting: true),
      ),
    );

    if (selectedLocation.latitude == 0.0000 &&
        selectedLocation.longitude == 0.0000) {
      return;
    }

    widget.onSelectPixelPlace(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: _previewImageUrl.isEmpty
              ? Text(
                  'No location chosen yet.',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.my_location,
              ),
              label: Text('Current Location'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _getPixelLocation,
            ),
            TextButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Select Location'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
