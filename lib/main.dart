import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/map_screen.dart';
import './screens/place_detail_screen.dart';

import './providers/pixel_places_provider.dart';

Future main() async{
  await dotenv.load(fileName: '.env');
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
          accentColor: Colors.blueGrey,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          MapScreen.routeName: (ctx) => MapScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
