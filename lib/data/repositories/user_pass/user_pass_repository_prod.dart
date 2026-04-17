import 'package:bike_rental_project/data/dtos/user/user_pass_dto.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserPassRepositoryProd implements UserPassRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<UserPass?> getActiveUserPass(String userId) {
    return firestore
        .collection("user_passes")
        .where(UserPassDto.userIdKey, isEqualTo: userId)
        .orderBy(UserPassDto.expirationDateKey, descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          final doc = snapshot.docs.first;
          debugPrint("It works");
          UserPass result = UserPassDto.fromJson(doc.id, doc.data());
          if (result.passStatus == PassStatus.active) {
            return result;
          } else {
            return null;
          }
        });
  }

  @override
  Future<UserPass> createUserPass(UserPass newUserPass) async {
    // 1. Perform query before the transaction
    final querySnapshot = await firestore
        .collection("user_passes")
        .where("userId", isEqualTo: newUserPass.userId)
        .where("expirationDate", isGreaterThan: Timestamp.now())
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      throw Exception("User currently has an active subscription.");
    }

    // 2. Start transaction only for the write
    return await firestore.runTransaction((transaction) async {
      final docRef = firestore.collection("user_passes").doc(newUserPass.id);
      transaction.set(docRef, UserPassDto.toJson(newUserPass));
      return newUserPass;
    });
  }
}
