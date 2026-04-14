import 'package:flutter/material.dart';

class PassSubscription {
  final String id;
  final String title;
  final Map<IconData, String> coreBenefits;
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
