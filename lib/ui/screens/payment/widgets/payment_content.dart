import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/screens/payment/view_model/payment_view_model.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/utils/async_value.dart';
import 'package:bike_rental_project/ui/utils/nav_util.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_dialog.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_filled_button.dart';
import 'package:bike_rental_project/ui/widgets/pass_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class PaymentContent extends StatefulWidget {
  const PaymentContent({super.key});

  @override
  State<PaymentContent> createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {
  bool termServiceAgreed = false;

  Future<void> onPay() async {
    final vm = context.read<PaymentViewModel>();
    await vm.confirmPayment();
    if (vm.paymentStatus != null && mounted) {
      switch (vm.paymentStatus!.state) {
        case AsyncValueState.loading:
          break;
        case AsyncValueState.error:
          showDialog(
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Payment Error!",
              description: vm.paymentStatus!.error.toString(),
            ),
          );
          break;
        case AsyncValueState.success:
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => BikeRentalDialog(
              title: "Payment Complete",
              description: "Thank you for subscribing the Daily Pass.",
              action: SizedBox(
                width: 212,
                child: BikeRentalButton(
                  label: "Find Station",
                  onPressed: () {
                    NavUtil.toHome(ScreenNavigation.map);
                  },
                ),
              ),
            ),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PaymentViewModel>();
    String format = "dd MMM yyyy, hh:mm a";
    String startDate = DateFormat(format).format(DateTime.now());
    String endDate = DateFormat(
      format,
    ).format(DateTime.now().add(vm.selectedSubs.validDuration));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => NavUtil.back(),
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
              const SizedBox(height: 15),
              PassCard(
                title: vm.selectedSubs.title,
                coreBenefits: vm.selectedSubs.coreBenefits,
                action: const SizedBox(height: 15),
              ),
              const SizedBox(height: 40),
              const Text("Validity", style: AppTheme.titleLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(startDate, style: AppTheme.bodyMedium),
                  Icon(Symbols.arrow_forward_ios, color: AppTheme.primary),
                  Text(endDate, style: AppTheme.bodyMedium),
                ],
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
            SizedBox(
              height: 50,
              child: BikeRentalButton(
                onPressed: termServiceAgreed ? onPay : null,
                label: vm.buttonLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
