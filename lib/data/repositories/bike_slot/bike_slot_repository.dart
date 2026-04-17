import 'package:bike_rental_project/model/bike/bike_slot.dart';

abstract class BikeSlotRepository {
  Future<List<BikeSlot>> getBikeSlots();
  Future<void> updateBikeSlotStatus(String bikeSlotId, BikeSlotStatus status);
}
