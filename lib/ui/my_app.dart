import 'package:bike_rental_project/ui/screens/pass_selection/pass_selection_screen.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/widgets/navigation_bar/bike_rental_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum ScreenNavigation {
  profile(iconData: Symbols.server_person_rounded, label: "My Profile"),
  map(iconData: Symbols.map, label: "Find Station"),
  passOption(iconData: Symbols.passport_rounded, label: "Pass Options");

  final IconData iconData;
  final String label;
  const ScreenNavigation({required this.iconData, required this.label});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScreenNavigation selectedScreenNavigation = ScreenNavigation.passOption;

  void changeScreen(ScreenNavigation newSelectedScreen) {
    if (selectedScreenNavigation != newSelectedScreen) {
      setState(() {
        selectedScreenNavigation = newSelectedScreen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bike Rental',
      theme: AppTheme.lightTheme,
      scrollBehavior: const ScrollBehavior().copyWith(
        physics: const ClampingScrollPhysics(),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              Icon(
                selectedScreenNavigation.iconData,
                size: 40,
                color: AppTheme.primary,
              ),
              Text(
                selectedScreenNavigation.label,
                style: AppTheme.headlineMedium,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: IndexedStack(
              index: selectedScreenNavigation.index,
              children: [Placeholder(), Placeholder(), PassSelectionScreen()],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: BikeRentalBottomNavigationBar(
            changeScreen: changeScreen,
            currentSelectedScreen: selectedScreenNavigation,
          ),
        ),
      ),
    );
  }
}
