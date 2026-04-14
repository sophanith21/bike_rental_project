import 'package:bike_rental_project/ui/screens/pass_selection/view_model/pass_selection_view_model.dart';
import 'package:bike_rental_project/ui/screens/payment/payment_screen.dart';
import 'package:bike_rental_project/ui/utils/async_value.dart';
import 'package:bike_rental_project/ui/widgets/bike_rental_filled_button.dart';
import 'package:bike_rental_project/ui/widgets/pass_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassSelectionContent extends StatelessWidget {
  const PassSelectionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PassSelectionViewModel>();
    final passSubsAsyncValue = vm.passSubscriptionsAsyncValue;
    Widget content;

    switch (passSubsAsyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(child: Text(passSubsAsyncValue.error.toString()));
        break;
      case AsyncValueState.success:
        final data = passSubsAsyncValue.data!;
        content = ListView.separated(
          itemBuilder: (context, index) => PassCard(
            title: data[index].title,
            coreBenefits: data[index].coreBenefits,
            action: SizedBox(
              width: 213,
              child: BikeRentalButton(
                isFilled:
                    !vm.isSubscriptionActive ||
                    data[index].id == vm.activePass?.passSubscriptionId,
                label: "\$${data[index].price.toStringAsFixed(2)}",
                onPressed: vm.isSubscriptionActive
                    ? () {}
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentScreen(selectedSubs: data[index]),
                          ),
                        );
                      },
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(height: 37),
          itemCount: data.length,
        );
        break;
    }

    return content;
  }
}
