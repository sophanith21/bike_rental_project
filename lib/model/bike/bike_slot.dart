enum BikeSlotStatus { empty, occupied }

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
}
