import 'package:todo_design_weak3/features/auth/data/models/usermodel.dart';

class LoginResult {
  final UserModel? user;
  final String? message;
  final bool isSuccess;

  LoginResult.success(this.user) : message = null, isSuccess = true;

  LoginResult.failure(this.message) : user = null, isSuccess = false;
}
