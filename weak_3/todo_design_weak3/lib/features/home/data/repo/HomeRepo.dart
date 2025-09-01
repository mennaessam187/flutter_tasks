import 'package:dartz/dartz.dart';
import 'package:todo_design_weak3/features/auth/data/models/usermodel.dart';

abstract class Homerepo {
  void usersignouthome();
  Future<Either<String, UserModel>> getUser(String? id );
}
