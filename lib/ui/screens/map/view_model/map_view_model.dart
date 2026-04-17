import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/data/repositories/bike_station/bike_station_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:bike_rental_project/utils/routing_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapViewModel extends ChangeNotifier {
  final BikeStationRepository bikeStationRepository;
  final BikeSlotRepository bikeSlotRepository;

  final DraggableScrollableController sheetController =
      DraggableScrollableController();
  UserState userState;

  MapViewModel({
    required this.bikeStationRepository,
    // required this.bikeSlotStatus,
    required this.bikeSlotRepository,
    required this.userState,
  }) {
    loadBikeStations();
    userState.addListener(onUserStateChanged);
  }
  void updateUserState(UserState newUserState) {
    userState.removeListener(onUserStateChanged);
    userState = newUserState;
    userState.addListener(onUserStateChanged);
    notifyListeners();
  }

  void onUserStateChanged() {
    print('UserState changed — booking: ${userState.booking?.bookingStatus}');
    print('bikeSlotStatus: $bikeSlotStatus');
    notifyListeners();
    loadBikeStations();
  }

  //join
  Map<String, BikeStation> stationsById = {};
  Map<String, BikeSlot> bikeSlotsById = {};

  // station
  List<BikeStation> allBikeStations = [];
  BikeStation? selectedStation;
  AsyncValue<List<BikeStation>>? stationsState;

  // controller
  final TextEditingController searchController = TextEditingController();
  final MapController mapController = MapController();

  Booking? get booking => userState.booking;
  BikeSlotStatus get bikeSlotStatus =>
      userState.isRelease ? BikeSlotStatus.empty : BikeSlotStatus.occupied;

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

  // Search
  void clearSearch() {
    searchController.clear();
    final List<BikeStation> source = stationsWithStatus(bikeSlotStatus);
    stationsState = AsyncValue.success(source);
    print("Clear search");
    notifyListeners();
  }

  @override
  void dispose() {
    userState.removeListener(onUserStateChanged);
    searchController.dispose();
    mapController.dispose();
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

  // Helper methods for when booking is active
  BikeStation? findBikeStation(String stationId) {
    return stationsById[stationId];
  }

  BikeSlot? findBikeSlot(String slotId) {
    return bikeSlotsById[slotId];
  }

  void selectStation(BikeStation? station) {
    selectedStation = station;
    mapController.move(station!.stationLocation, 16);
    print("selected");
    notifyListeners();
  }

  void clearSelection() {
    selectedStation = null;
    clearRoute();
    print("deselected");
    notifyListeners();
  }

  // User Location
  LatLng? userLocation;
  AsyncValue<LatLng>? userLocationState;

  Future<void> loadUserLocation() async {
    try {
      userLocationState = AsyncValue.loading();
      notifyListeners();

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      final position = await Geolocator.getCurrentPosition();
      userLocation = LatLng(position.latitude, position.longitude);
      mapController.move(userLocation!, 16);
      userLocationState = AsyncValue.success(userLocation!);
    } catch (e) {
      userLocationState = AsyncValue.error(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> goToUserLocation() async {
    if (userLocation == null) {
      await loadUserLocation();
    }
    if (userLocation == null) return;
    mapController.move(userLocation!, 16);

    notifyListeners();
  }

  // Route
  List<LatLng> routePoints = [];
  AsyncValue<List<LatLng>>? routeState;

  Future<void> loadRoute() async {
    if (selectedStation == null) return;
    if (userLocation == null) {
      await loadUserLocation();
    }
    if (userLocation == null) return;

    try {
      routeState = AsyncValue.loading();
      notifyListeners();

      final points = await RoutingService.getRoute(
        from: userLocation!,
        to: selectedStation!.stationLocation,
      );

      routePoints = points;
      routeState = AsyncValue.success(points);
    } catch (e) {
      routeState = AsyncValue.error(e);
    } finally {
      notifyListeners();
    }
  }

  void clearRoute() {
    routePoints = [];
    routeState = null;
    notifyListeners();
  }
}
