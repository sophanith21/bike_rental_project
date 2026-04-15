import 'package:bike_rental_project/model/booking/benefit.dart';

class PassSubscription {
  final String id;
  final String title;
  final List<Benefit> coreBenefits;
  final double price;
  final Duration validDuration;

  const PassSubscription({
    required this.id,
    required this.title,
    required this.price,
    required this.coreBenefits,
    required this.validDuration,
  });
}
