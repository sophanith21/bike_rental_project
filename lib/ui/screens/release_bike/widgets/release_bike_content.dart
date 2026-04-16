import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/screens/pass_selection/pass_selection_screen.dart';
import 'package:bike_rental_project/ui/screens/release_bike/view_model/release_bike_view_model.dart';
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

class ReleaseBikeContent extends StatefulWidget {
  const ReleaseBikeContent({super.key});

  @override
  State<ReleaseBikeContent> createState() => _ReleaseBikeContentState();
}

class _ReleaseBikeContentState extends State<ReleaseBikeContent> {
  bool termServiceAgreed = false;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReleaseBikeViewModel>();

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
        title: const Text("Release a bike", style: AppTheme.titleLarge),
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
              "Selected bike",
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
                text: "Rent Date: ",
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: formattedDate, style: AppTheme.bodyMedium),
                ],
              ),
            ),
            const Spacer(),
            if (vm.isSubscriptionActive)
              TicketWidgetHorizontal(
                leftContent: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 17,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Subscription Active: ",
                          style: AppTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Daily Pass",
                              style: AppTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "End Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(vm.userPass!.expirationDate.toLocal())}",
                        style: AppTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                rightContent: Icon(
                  Symbols.check_circle_rounded,
                  fill: 1,
                  size: 40,
                  color: AppTheme.primary,
                ),
              ),
            const SizedBox(height: 15),
            // Bottom Section: Policy and Payment
            if (!vm.isBookingTheSlot)
              Row(
                spacing: 12,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      termServiceAgreed = !termServiceAgreed;
                    }),
                    icon: Icon(
                      termServiceAgreed
                          ? Symbols.check_box
                          : Symbols.check_box_outline_blank,
                      fill: 1,
                      size: 21,
                      color: AppTheme.primary,
                    ),
                  ),
                  Text(
                    "I agree to the Terms of Service and Privacy Policy",
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            if (!vm.isBookingTheSlot)
              Text(
                "Includes first 30 mins. Then \$0.49 per 30 mins.",
                style: AppTheme.bodySmall.copyWith(fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 15),
            (vm.isBookingTheSlot)
                ? BikeRentalButton(label: vm.payLabel, onPressed: onBikeRelease)
                : BikeRentalButton(
                    label: vm.payLabel,
                    onPressed: termServiceAgreed && !vm.hasBookedAlready
                        ? onBookBike
                        : null,
                  ),

            const SizedBox(height: 15),
            if (!vm.isSubscriptionActive && !vm.hasBookedAlready)
              BikeRentalButton(
                isFilled: false,
                label: "Find Subscriptions",
                onPressed: onFindSubscriptions,
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> onBikeRelease() async {
    final vm = context.read<ReleaseBikeViewModel>();
    await vm.releaseBike();
    if (vm.releaseBikeStatus != null && mounted) {
      switch (vm.releaseBikeStatus!.state) {
        case AsyncValueState.loading:
          break;
        case AsyncValueState.error:
          showDialog(
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Release Bike Error!",
              description: vm.releaseBikeStatus!.error.toString(),
            ),
          );
          break;
        case AsyncValueState.success:
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Bike Released",
              description: "Thank you for using our services.",
              action: BikeRentalButton(
                label: "Check Map",
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

  Future<void> onBookBike() async {
    final vm = context.read<ReleaseBikeViewModel>();
    await vm.onBikeBooked();
    if (vm.bookingProcessStatus != null && mounted) {
      switch (vm.bookingProcessStatus!.state) {
        case AsyncValueState.loading:
          break;
        case AsyncValueState.error:
          showDialog(
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Payment Error!",
              description: vm.bookingProcessStatus!.error.toString(),
            ),
          );
          break;
        case AsyncValueState.success:
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Payment Complete",
              description: "Thank you for using our services.",
              action: Column(
                spacing: 15,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BikeRentalButton(
                    label: "Release the bike",
                    onPressed: () {
                      NavUtil.back();
                      onBikeRelease();
                    },
                  ),
                  BikeRentalButton(
                    label: "Check Map",
                    isFilled: false,
                    onPressed: () {
                      NavUtil.toHome(ScreenNavigation.map);
                    },
                  ),
                ],
              ),
            ),
          );
          break;
      }
    }
  }

  void onFindSubscriptions() {
    NavUtil.to(
      Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => NavUtil.back(),
            icon: Icon(Symbols.arrow_back, size: 40, color: AppTheme.primary),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              Icon(
                ScreenNavigation.passOption.iconData,
                size: 40,
                color: AppTheme.primary,
              ),
              Text(
                ScreenNavigation.passOption.label,
                style: AppTheme.headlineMedium,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: PassSelectionScreen(),
          ),
        ),
      ),
    );
  }
}
