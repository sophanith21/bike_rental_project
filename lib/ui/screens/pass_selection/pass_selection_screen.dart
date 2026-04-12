import 'package:bike_rental_project/ui/screens/payment/payment_screen.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_filled_button.dart';
import 'package:bike_rental_project/ui/widgets/pass_card.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PassSelectionScreen extends StatelessWidget {
  const PassSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PassCard(
          title: 'Daily Explorer',
          coreBenefits: {
            Symbols.nest_clock_farsight_analog: "Unlimited 30mins ride",
            Symbols.calendar_check: "Valid for 24 hours",
            Symbols.pedal_bike_rounded: "Quick \"Grab & Go\" access",
          },
          action: SizedBox(
            width: 213,
            child: BikeRentalButton(
              label: "\$2.00",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
