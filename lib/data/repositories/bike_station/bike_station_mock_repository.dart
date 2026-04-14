import 'package:bike_rental_project/data/repositories/bike_station/bike_station_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:latlong2/latlong.dart';

class BikeStationMockRepository implements BikeStationRepository {
  @override
  Future<List<BikeStation>> getBikeStations() async {
    return mockBikeStations;
  }
}

final List<BikeSlot> mockBikeSlots = [
  // Station 001 Slots
  BikeSlot(
    id: 'slot_001',
    bikeSlotStatus: BikeSlotStatus.occupied,
    slotNumber: 1,
    bikeStationId: 'station_001',
  ),
  BikeSlot(
    id: 'slot_002',
    bikeSlotStatus: BikeSlotStatus.occupied,
    slotNumber: 2,
    bikeStationId: 'station_001',
  ),
  BikeSlot(
    id: 'slot_003',
    bikeSlotStatus: BikeSlotStatus.empty,
    slotNumber: 3,
    bikeStationId: 'station_001',
  ),

  // Station 002 Slots
  BikeSlot(
    id: 'slot_004',
    bikeSlotStatus: BikeSlotStatus.empty,
    slotNumber: 1,
    bikeStationId: 'station_002',
  ),
  BikeSlot(
    id: 'slot_005',
    bikeSlotStatus: BikeSlotStatus.empty,
    slotNumber: 2,
    bikeStationId: 'station_002',
  ),
  BikeSlot(
    id: 'slot_006',
    bikeSlotStatus: BikeSlotStatus.occupied,
    slotNumber: 3,
    bikeStationId: 'station_002',
  ),
  BikeSlot(
    id: 'slot_007',
    bikeSlotStatus: BikeSlotStatus.empty,
    slotNumber: 4,
    bikeStationId: 'station_002',
  ),

  // Station 003 Slots
  BikeSlot(
    id: 'slot_008',
    bikeSlotStatus: BikeSlotStatus.occupied,
    slotNumber: 1,
    bikeStationId: 'station_003',
  ),
  BikeSlot(
    id: 'slot_009',
    bikeSlotStatus: BikeSlotStatus.occupied,
    slotNumber: 2,
    bikeStationId: 'station_003',
  ),

  // Station 004 Slots
  BikeSlot(
    id: 'slot_010',
    bikeSlotStatus: BikeSlotStatus.empty,
    slotNumber: 1,
    bikeStationId: 'station_004',
  ),
  BikeSlot(
    id: 'slot_011',
    bikeSlotStatus: BikeSlotStatus.occupied,
    slotNumber: 2,
    bikeStationId: 'station_004',
  ),
  BikeSlot(
    id: 'slot_012',
    bikeSlotStatus: BikeSlotStatus.empty,
    slotNumber: 3,
    bikeStationId: 'station_004',
  ),
];

// 2. Now define the Stations using the IDs from the list above
final List<BikeStation> mockBikeStations = [
  BikeStation(
    id: 'station_001',
    stationName: 'Wat Phnom Station',
    stationLocation: LatLng(11.5765, 104.9214),
  ),
  BikeStation(
    id: 'station_002',
    stationName: 'Riverside Station',
    stationLocation: LatLng(11.5694, 104.9301),
  ),
  BikeStation(
    id: 'station_003',
    stationName: 'Central Market Station',
    stationLocation: LatLng(11.5637, 104.9225),
  ),
  BikeStation(
    id: 'station_004',
    stationName: 'Olympic Stadium Station',
    stationLocation: LatLng(11.5556, 104.9228),
  ),
];
