abstract class ChangepasswordState {}

class ChangepasswordinitState extends ChangepasswordState {}

class ChangepasswordloadingState extends ChangepasswordState {}

class ChangepasswordSuccessState extends ChangepasswordState {}

class ChangepasswordErrorState extends ChangepasswordState {
  String message;
  ChangepasswordErrorState({required this.message});
}
