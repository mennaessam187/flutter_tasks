import 'package:dartz/dartz.dart';

abstract class ProfileRepo {
  Future<Either<String, Unit>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
