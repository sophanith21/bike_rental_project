import 'package:bike_rental_project/ui/map/map_screen.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // makes the mouse click consider as touch (for dragable scrollable sheet to work)
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      // home: Scaffold(appBar: AppBar(title: Text("Bike Rental App"))),
      home: MapScreen(),
    );
  }
}
