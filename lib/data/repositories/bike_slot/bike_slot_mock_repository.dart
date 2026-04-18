import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/data/repositories/bike_station/bike_station_mock_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';

class BikeSlotMockRepository implements BikeSlotRepository {
  @override
  Future<List<BikeSlot>> getBikeSlots() async {
    return mockBikeSlots;
  }

  @override
  Future<void> updateBikeSlotStatus(
    String bikeSlotId,
    BikeSlotStatus status,
  ) async {
    int targetIndex = mockBikeSlots.indexWhere((e) => e.id == bikeSlotId);
    if (targetIndex != -1) {
      mockBikeSlots[targetIndex] = mockBikeSlots[targetIndex].copyWith(
        bikeSlotStatus: status,
      );
    }
  }
}
