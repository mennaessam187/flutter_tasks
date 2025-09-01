class LoginState {}

class InitialState extends LoginState {}

class UpdatePassword extends LoginState {
  bool initialValue = false;
  UpdatePassword({required this.initialValue});
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  String? errorMessage;
  LoginErrorState({required this.errorMessage});
}

class ForgetPasswordSucessState extends LoginState {}

class ForgetPasswordloadingState extends LoginState {}

class ForgetPassworderorrState extends LoginState {
  String? errorMessage;
  ForgetPassworderorrState({required this.errorMessage});
}
