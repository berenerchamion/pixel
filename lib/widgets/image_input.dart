import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:path/path.dart' as p;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Image _storedImage = Image(
    image: AssetImage('assets/images/no-image-icon-23494.png'),
  );

  Future<void> _takePicture() async {
    final _imagePicker = ImagePicker();
    final XFile? _imageFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    //This can happen if the user hits the back button
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = Image.file(File(_imageFile.path));
    });
    final appDir = await pp.getApplicationDocumentsDirectory();
    final fileName = p.basename(_imageFile.path);
    await _imageFile.saveTo('${appDir.path}/$fileName');
    widget.onSelectImage(_imageFile);
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
