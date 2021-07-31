import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/places_list_screen.dart';

import './providers/pixel_places_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PixelPlacesProvider(),
      child: MaterialApp(
        title: 'Pixel\'s Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.amber,
        ),
        home: PlacesListScreen(),
      ),
    );
  }
}
