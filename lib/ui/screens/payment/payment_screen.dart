import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_dialog.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_filled_button.dart';
import 'package:bike_rental_project/ui/widgets/pass_card.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Symbols.arrow_back, size: 40, color: AppTheme.primary),
        ),

        title: const Text("Payment", style: AppTheme.headlineMedium),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ListView(
            children: [
              const Text("Selected Pass", style: AppTheme.titleLarge),
              SizedBox(height: 15),
              PassCard(
                title: 'Daily Explorer',
                coreBenefits: {
                  Symbols.nest_clock_farsight_analog: "Unlimited 30mins ride",
                  Symbols.calendar_check: "Valid for 24 hours",
                  Symbols.pedal_bike_rounded: "Quick \"Grab & Go\" access",
                },
                action: SizedBox(height: 15),
              ),
              SizedBox(height: 40),
              const Text("Validity", style: AppTheme.titleLarge),
              Text(
                "27 Feb 2026, 09:30 AM → 28 Feb 2026, 09:30 AM",
                style: AppTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          spacing: 29,
          children: [
            Row(
              spacing: 12,
              children: [
                Icon(Icons.check_box, size: 21, color: AppTheme.primary),
                Text(
                  "I agree to the Terms of Service and Privacy Policy",
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: BikeRentalButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => BikeRentalDialog(
                      title: "Payment Complete",
                      description: "Thank you for subscribing the Daily Pass.",
                      action: SizedBox(
                        width: 212,
                        child: BikeRentalButton(
                          label: "Find Station",
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                },
                label: "Pay \$2.00",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
