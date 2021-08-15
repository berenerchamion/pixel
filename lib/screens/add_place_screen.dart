import 'package:flutter/material.dart';
import "dart:io";
import '../widgets/image_input.dart';
import 'package:cross_file/cross_file.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  XFile? _selectedImage;

  void _selectImage(XFile file) {
    _selectedImage = file;
  }

  void _savePlace () {
    if (_titleController.text.isEmpty || _selectedImage == null) {
      //@todo come back and fix this. 
      return;
    }
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
            onPressed: () {},
          ), //Button
        ],
      ), //Column
    );
  }
}
