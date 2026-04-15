import 'package:bike_rental_project/data/dtos/bike/bike_slot_dto.dart';
import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BikeSlotProductRepository implements BikeSlotRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<List<BikeSlot>> getBikeSlots() async {
    final snapshot = await db.collection('bike_slots').get();
    return snapshot.docs
        .map((doc) => BikeSlotDto.fromJson(doc.id, doc.data()))
        .toList();
  }
}
