enum BikeSlotStatus { empty, occupied, booked }

class BikeSlot {
  final String id;
  final int slotNumber;
  final String bikeStationId;
  final BikeSlotStatus bikeSlotStatus;

  const BikeSlot({
    required this.id,
    required this.slotNumber,
    required this.bikeStationId,
    required this.bikeSlotStatus,
  });

  BikeSlot copyWith({
    String? id,
    int? slotNumber,
    String? bikeStationId,
    BikeSlotStatus? bikeSlotStatus,
  }) {
    return BikeSlot(
      id: id ?? this.id,
      slotNumber: slotNumber ?? this.slotNumber,
      bikeStationId: bikeStationId ?? this.bikeStationId,
      bikeSlotStatus: bikeSlotStatus ?? this.bikeSlotStatus,
    );
  }
}
