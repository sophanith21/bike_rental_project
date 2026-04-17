import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/ui/screens/map/widgets/location_marker.dart';
import 'package:bike_rental_project/ui/screens/map/view_model/map_view_model.dart';
import 'package:bike_rental_project/ui/screens/map/widgets/station_panel.dart';
import 'package:bike_rental_project/ui/screens/release_bike/release_bike_screen.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:bike_rental_project/utils/nav_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final MapViewModel mapVm = context.watch<MapViewModel>();
    debugPrint("From MapContent: ${mapVm.booking}");
    final List<BikeStation> stationValues = mapVm.stationsState?.data ?? [];
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapVm.mapController,
            options: MapOptions(
              initialCenter: LatLng(11.556, 104.928),
              initialZoom: 15.2,
            ),
            children: [
              TileLayer(
                // urlTemplate:
                //     'https://tiles.stadiamaps.com/tiles/stamen_toner/{z}/{x}/{y}.png',
                urlTemplate:
                    'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),

              if (mapVm.routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: mapVm.routePoints,
                      strokeWidth: 4,
                      color: AppTheme.secondary,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: stationValues
                    .map(
                      (s) => Marker(
                        point: s.stationLocation,
                        width: 60,
                        height: 60,
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: () => mapVm.selectStation(s),
                          child: LocationMarker(
                            isSelected: s.id == mapVm.selectedStation?.id,
                            count: mapVm
                                .slotsAtWithStatus(s.id, mapVm.bikeSlotStatus)
                                .length,
                            status: mapVm.bikeSlotStatus,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              if (mapVm.userLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: mapVm.userLocation!,
                      child: const Icon(
                        Symbols.target_rounded,
                        color: AppTheme.secondary,
                        size: 32,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Column(
              spacing: 10,
              children: [
                SearchBar(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  leading: const Icon(Icons.search_rounded),
                  onChanged: mapVm.onSearch,
                  controller: mapVm.searchController,
                  onTap: mapVm.clearSelection,
                  hintText: "Search",
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: AppTheme.primary, width: 2),
                  ),
                  trailing: [
                    if (mapVm.searchController.text != "")
                      IconButton(
                        onPressed: mapVm.clearSearch,
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: AppTheme.primary,
                          size: AppTheme.rLarge,
                        ),
                      ),
                  ],
                ),
                if (mapVm.booking != null)
                  ClipRRect(
                    borderRadius: AppTheme.brMedium,
                    child: Banner(
                      message: "Booked",
                      location: BannerLocation.topStart,
                      color: AppTheme.secondary,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          BikeStation? station = mapVm.findBikeStation(
                            mapVm.booking!.stationId,
                          );
                          BikeSlot? slot = mapVm.findBikeSlot(
                            mapVm.booking!.bikeSlotId,
                          );
                          if (station != null && slot != null) {
                            mapVm.selectStation(station);
                            NavUtil.to(
                              ReleaseBikeScreen(slot: slot, station: station),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.primary,
                              width: 2,
                            ),
                            borderRadius: AppTheme.brMedium,
                            color: AppTheme.bgColor,
                          ),
                          child: Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Symbols.pedal_bike_rounded,
                                size: 35,
                                color: AppTheme.primary,
                              ),
                              Text(
                                "${mapVm.booking?.stationName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppTheme.primary,
                                ),
                              ),
                              Text(
                                "Slot: ${mapVm.findBikeSlot(mapVm.booking!.bikeSlotId)!.slotNumber.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppTheme.primary, width: 2),
              ),
              heroTag: 'location',
              // mini: true,
              onPressed: mapVm.loadUserLocation,
              tooltip: 'My Location',
              child: mapVm.userLocationState?.state == AsyncValueState.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.accent2,
                      ),
                    )
                  : const Icon(Icons.my_location, color: AppTheme.secondary),
            ),
          ),

          if (mapVm.stationsState?.state == AsyncValueState.loading ||
              mapVm.routeState?.state == AsyncValueState.loading)
            Center(child: CircularProgressIndicator()),

          if (mapVm.selectedStation != null)
            DraggableScrollableSheet(
              initialChildSize: 0.37,
              minChildSize: 0.1,
              maxChildSize: 1,
              expand: true,
              snap: true,
              snapSizes: [0.37, 1],
              builder: (context, scrollController) {
                return NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    if (notification.extent <= 0.1) {
                      // If dragged almost to the bottom
                      mapVm.clearSelection();
                    }
                    return true;
                  },
                  child: StationDetailsPanel(
                    bikeSlots: mapVm.slotsAtWithStatus(
                      mapVm.selectedStation!.id,
                      mapVm.bikeSlotStatus,
                    ),
                    onDeselect: mapVm.clearSelection,
                    onDirection: mapVm.loadRoute,
                    onClearRoute: mapVm.clearRoute,
                    isDirection:
                        mapVm.routeState?.state == AsyncValueState.success,
                    onBooked: (slot) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReleaseBikeScreen(
                            slot: slot,
                            station: mapVm.selectedStation!,
                          ),
                        ),
                      );
                    },
                    status: mapVm.bikeSlotStatus,
                    station: mapVm.selectedStation!,
                    scrollController: scrollController,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
