import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future register({String? email, String? password, String? name});
  Future<Either<String, Unit>> login({String? email, String? password});
  forgetPassword({String? email});
}
