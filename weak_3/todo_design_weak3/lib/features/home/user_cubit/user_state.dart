import 'package:todo_design_weak3/features/auth/data/models/usermodel.dart';

abstract class UserState {}

class UserLodding extends UserState {}

class UserSuccess extends UserState {
  UserModel usermodel;
  UserSuccess({required this.usermodel});
}

class UserError extends UserState {
  String message;
  UserError({required this.message});
}
