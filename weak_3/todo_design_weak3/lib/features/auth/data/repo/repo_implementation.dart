import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_design_weak3/features/auth/data/repo/userRepo.dart';

class UserImplementation extends UserRepo {
  @override
  Future<Either<String, Unit>> login({String? email, String? password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      return Right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Left('Wrong password provided.');
      } else {
        return Left('Login failed: ${e.message}');
      }
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<String> register({
    String? email,
    String? password,
    String? name,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = credential.user!;

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': user.email,
        'emailVerified': user.emailVerified,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (!credential.user!.emailVerified) {
        await credential.user!.sendEmailVerification();
      }
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      }
      return e.message ?? "An error occurred";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> forgetPassword({String? email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
