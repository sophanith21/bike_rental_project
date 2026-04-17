import 'package:bike_rental_project/ui/screens/profile/view_model/profile_view_model.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_filled_button.dart';
import 'package:bike_rental_project/ui/widgets/ticket/ticket_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    return TicketWidget(
      topContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: SizedBox.square(
              dimension: 188,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/profile_image.png"),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Text(vm.username ?? "", style: AppTheme.titleLarge),
          const SizedBox(height: 17),
          Row(
            spacing: 13,
            children: [
              Icon(
                vm.isPassActive ? Symbols.check_circle : Symbols.cancel_rounded,
                fill: vm.isPassActive ? 1 : 0,
                color: AppTheme.primary,
                size: 40,
              ),
              vm.isPassActive
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Subscription Active: ",
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: vm.userPassName,
                                style: AppTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "End Date: ${vm.endDate}",
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.secondary,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "No Active Subscription",
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ],
      ),
      bottomContent: BikeRentalButton(label: "Log Out", onPressed: () {}),
    );
  }
}
