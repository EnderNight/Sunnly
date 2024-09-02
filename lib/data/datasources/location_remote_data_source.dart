import 'dart:convert';

import 'package:sunnly/core/keys.dart';
import 'package:sunnly/core/strings.dart';
import 'package:sunnly/data/models/location_model.dart';
import 'package:http/http.dart' as http;

class LocationRemoteDataSource {
  Future<List<LocationModel>> getLocation(String name) async {
    final url = Uri.http(
      openWeatherMapAuthority,
      geocodingPath,
      {
        'q': name,
        'limit': '5',
        'appid': openweathermapApiKey,
      },
    );

    final response = await http.get(url);

    assert(response.statusCode == 200, "Error in location request");

    final rawLocations = jsonDecode(response.body) as List;

    return rawLocations
        .map((rawLoc) => LocationModel.fromJson(rawLoc))
        .toList();
  }
}
