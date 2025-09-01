class RegisterState {}

class InitialState extends RegisterState {}

class UpdatePasswordR extends RegisterState {
  final bool initialValue;
  UpdatePasswordR({required this.initialValue});
}

class ConfirmPassword extends RegisterState {
  final bool initialValue;
  ConfirmPassword({required this.initialValue});
}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  String? errorMessage;
  RegisterErrorState({required this.errorMessage});
}

class Verify extends RegisterState {}
