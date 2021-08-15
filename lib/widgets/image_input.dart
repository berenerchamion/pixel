import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Image _storedImage = Image(
    image: AssetImage('assets/images/no-image-icon-23494.png'),
  );

  Future<void> _takePicture() async {
    final _imagePicker = ImagePicker();
    final XFile? imageFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = Image.file(File(imageFile!.path));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).accentColor,
            ),
          ),
          alignment: Alignment.center,
          child: Image(
                  image: _storedImage.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
