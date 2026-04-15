// nav_util.dart
import 'package:bike_rental_project/ui/my_app.dart';
import 'package:flutter/material.dart';

/// A utility class for managing app-wide navigation without requiring a [BuildContext].
///
/// Uses a [GlobalKey] attached to [MaterialApp]'s navigator to enable navigation
/// from anywhere in the app, including services and BLoCs.
///
/// Setup:
/// ```dart
/// MaterialApp(
///   navigatorKey: NavUtil.navigatorKey,
/// )
/// ```

class NavUtil {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final ValueNotifier<ScreenNavigation> tabIndex = ValueNotifier(
    ScreenNavigation.map,
  );

  static void toHome(ScreenNavigation screenNav) {
    // First pop everything to home
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
    // Then switch tab
    tabIndex.value = screenNav;
  }

  static void to(Widget page) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => page));
  }

  static void toReplacement(Widget page) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static void popUntilPage<T>() {
    navigatorKey.currentState?.popUntil(
      (route) => route.settings.name == T.toString(),
    );
  }

  static void back() {
    navigatorKey.currentState?.pop();
  }
}
