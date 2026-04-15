import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/ui/screens/pass_selection/view_model/pass_selection_view_model.dart';
import 'package:bike_rental_project/ui/screens/pass_selection/widgets/pass_selection_content.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassSelectionScreen extends StatelessWidget {
  const PassSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider2<
      UserState,
      PassSubscriptionRepository,
      PassSelectionViewModel
    >(
      update: (context, value, value2, previous) => PassSelectionViewModel(
        userState: value,
        passSubscriptionRepository: value2,
      ),
      create: (BuildContext context) {
        return PassSelectionViewModel(
          userState: context.read<UserState>(),
          passSubscriptionRepository: context
              .read<PassSubscriptionRepository>(),
        );
      },
      child: PassSelectionContent(),
    );
  }
}
