import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage = File('assets/images/product-placeholder.png');

  Future _takePicture() async {
    final _imagePicker = ImagePicker();
    final imageFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_storedImage.existsSync()) {
      print('I exist!');
    } else {
      print('I do not exist');
    }
    print(_storedImage.existsSync());

    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).accentColor,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage.existsSync()
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image taken.',
                  textAlign: TextAlign.center,
                ),
        ), //Container
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Take Picture'),
            icon: Icon(Icons.add_a_photo_rounded),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: _takePicture,
          ), //TextButton
        ), //Expanded
      ],
    ); //Row
  }
}
