import 'package:bike_rental_project/model/bike/bike_slot.dart';

class BikeSlotDto {
  static const String slotNumberKey = 'slot_number';
  static const String bikeStationIdKey = 'bike_station_id';
  static const String bikeSlotStatusKey = 'bike_slot_status';

  static BikeSlot fromJson(
    Map<String, dynamic> json, {
    required String documentId,
  }) {
    assert(json[slotNumberKey] is int);
    assert(json[bikeStationIdKey] is String);
    assert(json[bikeSlotStatusKey] is String);

    return BikeSlot(
      id: documentId,
      slotNumber: json[slotNumberKey] as int,
      bikeStationId: json[bikeStationIdKey] as String,
      bikeSlotStatus: BikeSlotStatus.values.byName(
        json[bikeSlotStatusKey] as String,
      ),
    );
  }

  static Map<String, dynamic> toJson(BikeSlot bikeSlot) {
    return {
      slotNumberKey: bikeSlot.slotNumber,
      bikeStationIdKey: bikeSlot.bikeStationId,
      bikeSlotStatusKey: bikeSlot.bikeSlotStatus.name,
    };
  }
}
