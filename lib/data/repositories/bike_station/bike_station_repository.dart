import 'package:bike_rental_project/model/bike/bike_station.dart';

abstract class BikeStationRepository {
  Future<List<BikeStation>> getBikeStations();
}
