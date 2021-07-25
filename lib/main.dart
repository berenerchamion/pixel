import 'package:flutter/material.dart';
import './screens/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel\'s Places',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.amber,
      ),
      home: PlacesListScreen(),
    );
  }
}
