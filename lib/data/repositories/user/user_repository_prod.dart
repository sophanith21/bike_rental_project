import 'package:bike_rental_project/data/dtos/user/user_dto.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/model/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepositoryProd implements UserRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<User?> getUser(String username, String password) async {
    final snapshot = await firestore
        .collection('users')
        .where("name", isEqualTo: username)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return UserDto.fromJson(snapshot.docs.first.id, snapshot.docs.first.data());
  }
}
