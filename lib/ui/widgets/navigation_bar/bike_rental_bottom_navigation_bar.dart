import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/widgets/navigation_bar/selected_tab.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BikeRentalBottomNavigationBar extends StatelessWidget {
  final ValueChanged<ScreenNavigation> changeScreen;
  final ScreenNavigation currentSelectedScreen;
  const BikeRentalBottomNavigationBar({
    super.key,
    required this.changeScreen,
    required this.currentSelectedScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 70,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primary, width: 2),
                borderRadius: AppTheme.brLarge,
              ),
            ),
          ),

          // Actual nav items
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectedTab(
                  screenNavigation: ScreenNavigation.profile,
                  label: 'Profile',
                  iconData: Symbols.person,
                  iconFill: true,
                  onTap: changeScreen,
                  currentSelectedScreen: currentSelectedScreen,
                ),
                SelectedTab(
                  screenNavigation: ScreenNavigation.map,
                  label: 'Map',
                  iconData: Symbols.map,
                  onTap: changeScreen,
                  currentSelectedScreen: currentSelectedScreen,
                ),
                SelectedTab(
                  screenNavigation: ScreenNavigation.passOption,
                  label: 'Pass',
                  iconData: Symbols.passport_rounded,
                  onTap: changeScreen,
                  currentSelectedScreen: currentSelectedScreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
