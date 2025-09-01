import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/features/auth/cubit/register_cubit/register_state.dart';
import 'package:todo_design_weak3/features/auth/data/repo/repo_implementation.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordObscure = true;
  bool isConfirmObscure = true;
  changePassword() {
    isPasswordObscure = !isPasswordObscure;
    emit(UpdatePasswordR(initialValue: isPasswordObscure));
  }

  confirmchangePassword() {
    isConfirmObscure = !isConfirmObscure;
    emit(ConfirmPassword(initialValue: isConfirmObscure));
  }

  register() async {
    emit(RegisterLoadingState());
    UserImplementation u11 = UserImplementation();
    var result = await u11.register(
      email: Textformfieldcontroller.registeremailcontroller.text,
      name: Textformfieldcontroller.namecontroller.text,
      password: Textformfieldcontroller.registerpasswordcontroller.text,
    );

    if (result == "success") {
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState(errorMessage: result));
    }
  }
}

/*
   // if (result == "success") {
    //   User? user = FirebaseAuth.instance.currentUser;
    //   if (user != null && !user.emailVerified) {
    //     await user.sendEmailVerification();
    //   }
    //   emit(RegisterSuccessState());
    // } else {
    //   emit(RegisterErrorState(errorMessage: result));
    // }

*/
