import 'package:bike_rental_project/model/bike/bike_slot.dart';

class BikeSlotDto {
  static const String idKey = 'id';
  static const String slotNumberKey = 'slotNumber';
  static const String bikeStationIdKey = 'bikeStationId';
  static const String bikeSlotStatusKey = 'bikeSlotStatus';

  static BikeSlot fromJson(String id, Map<String, dynamic> json) {
    assert(json[slotNumberKey] is int);
    assert(json[bikeStationIdKey] is String);
    assert(json[bikeSlotStatusKey] is String);

    return BikeSlot(
      id: id,
      slotNumber: json[slotNumberKey],
      bikeStationId: json[bikeStationIdKey],
      bikeSlotStatus: BikeSlotStatus.values.byName(json[bikeSlotStatusKey]),
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
