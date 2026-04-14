import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class BikeStationDto {
  static const String stationNameKey = 'station_name';
  static const String stationLocationKey = 'station_location';

  static BikeStation fromJson(
    Map<String, dynamic> json, {
    required String documentId,
  }) {
    assert(json[stationNameKey] is String);
    assert(json[stationLocationKey] is GeoPoint);

    final GeoPoint geoPoint = json[stationLocationKey] as GeoPoint;

    return BikeStation(
      id: documentId,
      stationName: json[stationNameKey] as String,
      stationLocation: LatLng(
        geoPoint.latitude,
        geoPoint.longitude,
      ), // GeoPoint to LatLng
    );
  }

  static Map<String, dynamic> toJson(BikeStation station) {
    return {
      stationNameKey: station.stationName,
      stationLocationKey: GeoPoint(
        // LatLng to GeoPoint
        station.stationLocation.latitude,
        station.stationLocation.longitude,
      ),
    };
  }
}
