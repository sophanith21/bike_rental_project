import 'package:bike_rental_project/firebase_options.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/util/seed_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bike_rental_project/ui/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await SeedData.seedAll(reset: true);
  runApp(const MyApp());
}
