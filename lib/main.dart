import 'package:bike_rental_project/firebase_options.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/util/seed_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await SeedData.seedAll(reset: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: Scaffold(appBar: AppBar(title: Text("Bike Rental App"))),
    );
  }
}
