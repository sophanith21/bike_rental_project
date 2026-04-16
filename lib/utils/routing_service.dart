import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:latlong2/latlong.dart';

class RoutingService {
  static const String baseUrl = 'https://router.project-osrm.org/route/v1';

  static Future<List<LatLng>> getRoute({
    required LatLng from,
    required LatLng to,
  }) async {
    final url = Uri.parse(
      '$baseUrl/driving/'
      '${from.longitude},${from.latitude};'
      '${to.longitude},${to.latitude}'
      '?geometries=geojson&overview=full',
    );

    final response = await https.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to get route: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    if (data['code'] != 'Ok') {
      throw Exception('OSRM error: ${data['code']}');
    }

    final coordinates = data['routes'][0]['geometry']['coordinates'] as List;

    return coordinates
        .map(
          (coord) => LatLng(
            (coord[1] as num).toDouble(),
            (coord[0] as num).toDouble(),
          ),
        )
        .toList();
  }
}
