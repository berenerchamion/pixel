import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';

  Future<void> _getPixelLocation() async {
    final locationData = await Location().getLocation();
    final staticPixelPlaceMapUrl = LocationHelper.generatePixelPlacePreview(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
    );
    setState(() {
      _previewImageUrl = staticPixelPlaceMapUrl;
    });
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
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
