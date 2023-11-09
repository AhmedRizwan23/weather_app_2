// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_2/models/weather_model.dart';
import 'package:http/http.dart' as http;

class weatherservice {
  weatherservice(
    this.apikey,
  );

  // ignore: non_constant_identifier_names
  String BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apikey;

  Future<Weather> getweather(String cityname) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityname&appid=$apikey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to get weather");
    }
  }

  Future getcurrentcity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // convert the position into list of placement objects
    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    // extract the cityname from the first placemark
    String? city = placemark[0].locality;
    return city ?? "city is null";
  }
}
