import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/features/auth/data/repo/repo_implementation.dart';
import 'package:todo_design_weak3/features/auth/cubit/logic_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  changePassword(bool baswordSecure) {
    baswordSecure = !baswordSecure;
    emit(UpdatePassword(initialValue: baswordSecure));
  }

  UserImplementation u1 = UserImplementation();
  login() async {
    emit(LoginLoadingState());

    var result = await u1.login(
      email: Textformfieldcontroller.loginemailcontroller.text,
      password: Textformfieldcontroller.loginpasswordcontroller.text,
    );
    result.fold(
      (error) => emit(LoginErrorState(errorMessage: error)),
      (_) => emit(LoginSuccessState()),
    );
  }

  forgetPasswordd() async {
    final result = await u1.forgetPassword(
      email: Textformfieldcontroller.loginemailcontroller.text,
    );

    if (result == "Success") {
      emit(ForgetPasswordSucessState());
    } else {
      emit(ForgetPassworderorrState(errorMessage: result));
    }
  }
}
