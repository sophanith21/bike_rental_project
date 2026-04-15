import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/ui/map/widgets/location_marker.dart';
import 'package:bike_rental_project/ui/map/view_model/map_view_model.dart';
import 'package:bike_rental_project/ui/map/widgets/station_panel.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final MapViewModel mapVm = context.watch<MapViewModel>();
    final List<BikeStation> stationValues = mapVm.stationsState?.data ?? [];
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
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
            ],
          ),

          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: SearchBar(
              leading: const Icon(Icons.search_rounded),
              onChanged: mapVm.onSearch,
              controller: mapVm.searchController,
              onTap: mapVm.clearSelection,
              hintText: "Search",
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          ),

          if (mapVm.stationsState?.state == AsyncValueState.loading)
            Center(child: CircularProgressIndicator()),

          if (mapVm.selectedStation != null)
            DraggableScrollableSheet(
              initialChildSize: 0.37,
              minChildSize: 0.37,
              maxChildSize: 1,
              expand: true,
              snap: true,
              snapSizes: [0.37, 1],
              builder: (context, scrollController) {
                return StationDetailsPanel(
                  bikeSlots: mapVm.slotsAtWithStatus(
                    mapVm.selectedStation!.id,
                    mapVm.bikeSlotStatus,
                  ),
                  onDeselect: mapVm.clearSelection,
                  onBooked: () {
                    //todo go to book on this specific slot
                  },
                  status: mapVm.bikeSlotStatus,
                  station: mapVm.selectedStation!,
                  scrollController: scrollController,
                );
              },
            ),
        ],
      ),
    );
  }
}
