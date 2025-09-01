import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_design_weak3/features/auth/data/models/usermodel.dart';
import 'package:todo_design_weak3/features/home/data/repo/HomeRepo.dart';

class RepoImplementation extends Homerepo {
  @override
  void usersignouthome() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<Either<String, UserModel>> getUser(String? uid) async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      UserModel user = UserModel.fromJson(userData.data()!);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
