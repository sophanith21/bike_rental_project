import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:bike_rental_project/ui/screens/payment/view_model/payment_view_model.dart';
import 'package:bike_rental_project/ui/screens/payment/widgets/payment_content.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  final PassSubscription selectedSubs;
  const PaymentScreen({super.key, required this.selectedSubs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentViewModel(
        selectedSubs: selectedSubs,
        userState: context.read<UserState>(),
      ),
      child: PaymentContent(),
    );
  }
}
