import 'package:bike_rental_project/data/dtos/booking/pass_subscription_dto.dart';
import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PassSubscriptionRepositoryProd implements PassSubscriptionRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<PassSubscription>> getAllPassSubscriptions() async {
    final snapshot = await firestore.collection('pass_subscriptions').get();

    return snapshot.docs
        .map((doc) => PassSubscriptionDto.fromJson(doc.id, doc.data()))
        .toList();
  }
}
