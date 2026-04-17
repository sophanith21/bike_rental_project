import 'package:latlong2/latlong.dart';

class BikeStation {
  final String id;
  final String stationName;
  final LatLng stationLocation;
  final double bikeRentPrice;

  const BikeStation({
    required this.id,
    required this.stationName,
    required this.stationLocation,
    required this.bikeRentPrice,
  });
}
