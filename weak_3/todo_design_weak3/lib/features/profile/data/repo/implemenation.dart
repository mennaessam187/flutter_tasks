import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_design_weak3/features/profile/data/repo/function.dart';

class ProfileRepoImplementation extends ProfileRepo {
  Future<Either<String, Unit>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    final cred = EmailAuthProvider.credential(
      email: user!.email!,
      password: oldPassword,
    );

    try {
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      return left(e.message!);
    }

    return right(unit);
  }
}