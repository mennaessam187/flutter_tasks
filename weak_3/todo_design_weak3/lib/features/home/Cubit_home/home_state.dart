class HomeState {}

class InitState extends HomeState {}

class SignOutLoading extends HomeState {}

class SignOutSuccess extends HomeState {}

class SignOutError extends HomeState {
  final String messageError;
  SignOutError({required this.messageError});
}
