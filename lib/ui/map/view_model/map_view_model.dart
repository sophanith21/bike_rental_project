import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/data/repositories/bike_station/bike_station_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:flutter/material.dart';

class MapViewModel extends ChangeNotifier {
  final BikeStationRepository bikeStationRepository;
  final BikeSlotRepository bikeSlotRepository;
  final BikeSlotStatus bikeSlotStatus;

  MapViewModel({
    required this.bikeStationRepository,
    required this.bikeSlotStatus,
    required this.bikeSlotRepository,
  }) {
    loadBikeStations();
  }

  bool isLoading = false;
  //join
  Map<String, BikeStation> stationsById = {};
  Map<String, BikeSlot> bikeSlotsById = {};

  // station
  List<BikeStation> allBikeStations = [];
  BikeStation? selectedStation;
  AsyncValue<List<BikeStation>>? stationsState;

  // controller
  final TextEditingController searchController = TextEditingController();

  List<BikeSlot> slotsAt(String stationId) =>
      bikeSlotsById.values.where((s) => s.bikeStationId == stationId).toList();

  List<BikeSlot> slotsAtWithStatus(String stationId, BikeSlotStatus status) =>
      bikeSlotsById.values
          .where(
            (s) => s.bikeStationId == stationId && s.bikeSlotStatus == status,
          )
          .toList();

  List<BikeStation> stationsWithStatus(BikeSlotStatus status) => stationsById
      .values
      .where((s) => slotsAt(s.id).any((slot) => slot.bikeSlotStatus == status))
      .toList();

  Future<void> loadBikeStations() async {
    try {
      stationsState = AsyncValue.loading();
      notifyListeners();
      final List<BikeStation> bikeStations = await bikeStationRepository
          .getBikeStations();
      final List<BikeSlot> bikeSlots = await bikeSlotRepository.getBikeSlots();

      stationsById = {for (var s in bikeStations) s.id: s};
      bikeSlotsById = {for (var b in bikeSlots) b.id: b};

      final List<BikeStation> filteredStations = stationsWithStatus(
        bikeSlotStatus,
      );
      stationsState = AsyncValue.success(filteredStations);
    } catch (e) {
      stationsState = AsyncValue.error(e);
      print(e);
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    final List<BikeStation> source = stationsWithStatus(bikeSlotStatus);
    stationsState = AsyncValue.success(source);
    print("Clear search");
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    final source = stationsWithStatus(bikeSlotStatus);
    if (query.isEmpty) {
      stationsState = AsyncValue.success(source);
    } else {
      final List<BikeStation> result = source
          .where(
            (s) => s.stationName.toLowerCase().trim().contains(
              query.toLowerCase().trim(),
            ),
          )
          .toList();
      stationsState = AsyncValue.success(result);
    }
    notifyListeners();
  }

  void selectStation(BikeStation? station) {
    selectedStation = station;
    print("selected");
    notifyListeners();
  }

  void clearSelection() {
    selectedStation = null;
    print("deselected");
    notifyListeners();
  }
}
