import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cross_file/cross_file.dart';

import '../providers/pixel_places_provider.dart';
import '../helpers/location_helper.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../models/pixel_location.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  XFile? _selectedImage;
  PixelLocation? _selectedLocation;

  void _selectImage(XFile file) {
    _selectedImage = file;
  }

  void _selectLocation(double lat, double long) async {
    String address = await LocationHelper.getPixelPlaceAddress(
      latitude: lat,
      longitude: long,
    );

    _selectedLocation = PixelLocation(
      latitude: lat,
      longitude: long,
      address: address,
    );
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      //@todo come back and fix this to include error handling.
      return;
    }
    Provider.of<PixelPlacesProvider>(
      context,
      listen: false,
    ).addPixelPlace(
      _titleController.value.text,
      _selectedImage!,
      _selectedLocation!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Pixel Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ), //TextField
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: ImageInput(_selectImage),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: LocationInput(_selectLocation),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ), //Column
              ),
            ),
          ), //Expanded
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _savePlace,
          ), //Button
        ],
      ), //Column
    );
  }
}
