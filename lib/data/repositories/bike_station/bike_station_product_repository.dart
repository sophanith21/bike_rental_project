import 'package:bike_rental_project/data/dtos/bike/bike_station_dto.dart';
import 'package:bike_rental_project/data/repositories/bike_station/bike_station_repository.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BikeStationProductRepository implements BikeStationRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<List<BikeStation>> getBikeStations() async {
    final snapshot = await db.collection('bike_stations').get();
    return snapshot.docs
        .map((doc) => BikeStationDto.fromJson(doc.id, doc.data()))
        .toList();
  }
}
