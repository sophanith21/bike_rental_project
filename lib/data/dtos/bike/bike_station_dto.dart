import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:latlong2/latlong.dart';

class BikeStationDto {
  static const String idKey = 'id';
  static const String stationNameKey = 'stationName';
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';
  static const String bikeRentPriceKey = 'bikeRentPrice';

  static BikeStation fromJson(String id, Map<String, dynamic> json) {
    assert(json[stationNameKey] is String);
    assert(json[latitudeKey] is num);
    assert(json[longitudeKey] is num);
    assert(json[bikeRentPriceKey] is num);

    return BikeStation(
      id: id,
      stationName: json[stationNameKey],
      stationLocation: LatLng(
        (json[latitudeKey] as num).toDouble(),
        (json[longitudeKey] as num).toDouble(),
      ),
      bikeRentPrice: json[bikeRentPriceKey],
    );
  }

  static Map<String, dynamic> toJson(BikeStation bikeStation) {
    return {
      stationNameKey: bikeStation.stationName,
      latitudeKey: bikeStation.stationLocation.latitude,
      longitudeKey: bikeStation.stationLocation.longitude,
      bikeRentPriceKey: bikeStation.bikeRentPrice,
    };
  }
}
