import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LocationHelper {
  static String generatePixelPlacePreview({
    required double latitude,
    required double longitude,
  }) {
    final String _googleApiKey = dotenv.get('GOOGLE_API_KEY');
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude&$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Alabel:C%7C$latitude,$longitude&key=$_googleApiKey';
  }

  static Future<String> getPixelPlaceAddress ({
    required double latitude,
    required double longitude,
  }) async {
    final String _googleApiKey = dotenv.get('GOOGLE_API_KEY');
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_googleApiKey';
    Uri uri = Uri.parse(url);
    final response = await get(uri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
