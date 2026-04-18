import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/screens/pass_selection/pass_selection_screen.dart';
import 'package:bike_rental_project/ui/screens/release_bike/view_model/release_bike_view_model.dart';
import 'package:bike_rental_project/ui/screens/return_bike/view_model/return_bike_view_model.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_dialog.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_filled_button.dart';
import 'package:bike_rental_project/ui/widgets/ticket/ticket_widget_horizontal.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:bike_rental_project/utils/nav_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class ReturnBikeContent extends StatefulWidget {
  const ReturnBikeContent({super.key});

  @override
  State<ReturnBikeContent> createState() => _ReturnBikeContentState();
}

class _ReturnBikeContentState extends State<ReturnBikeContent> {
  bool termServiceAgreed = false;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReturnBikeViewModel>();

    String formattedDate = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => NavUtil.back(),
          icon: Icon(Symbols.arrow_back, size: 40, color: AppTheme.primary),
        ),
        title: const Text("Return a bike", style: AppTheme.titleLarge),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text.rich(
              TextSpan(
                text: "Station Name: ",
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: vm.selectedStation.stationName,
                    style: AppTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Selected Bike Slot",
              style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Bike Slot Display Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primary, width: 2),
                borderRadius: AppTheme.brMedium,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.primary),
                      borderRadius: AppTheme.brSmall,
                    ),
                    child: Text(
                      vm.selectedBikeSlot.slotNumber.toString().padLeft(2, '0'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "Bike Slot",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.pedal_bike_rounded,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text.rich(
              TextSpan(
                text: "Return Date: ",
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: formattedDate, style: AppTheme.bodyMedium),
                ],
              ),
            ),
            const Spacer(),

            BikeRentalButton(label: "Return the Bike", onPressed: onBikeReturn),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> onBikeReturn() async {
    final vm = context.read<ReturnBikeViewModel>();
    await vm.returnBike();
    if (vm.returnBikeStatus != null && mounted) {
      switch (vm.returnBikeStatus!.state) {
        case AsyncValueState.loading:
          break;
        case AsyncValueState.error:
          showDialog(
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Return Bike Error!",
              description: vm.returnBikeStatus!.error.toString(),
            ),
          );
          break;
        case AsyncValueState.success:
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Bike Returned",
              description: "Thank you for using our services.",
              action: BikeRentalButton(
                label: "Go to Map",
                onPressed: () {
                  NavUtil.toHome(ScreenNavigation.map);
                },
              ),
            ),
          );
          break;
      }
    }
  }
}
