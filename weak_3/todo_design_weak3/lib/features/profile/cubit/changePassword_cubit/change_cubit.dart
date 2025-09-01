import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/features/profile/cubit/changePassword_cubit/change_state.dart';
import 'package:todo_design_weak3/features/profile/data/repo/implemenation.dart';

class ChangePasswordCubit extends Cubit<ChangepasswordState> {
  ChangePasswordCubit() : super(ChangepasswordinitState());
  ProfileRepoImplementation t1 = ProfileRepoImplementation();
  changePassword() async {
    emit(ChangepasswordloadingState());
    try {
      final responce = await t1.changePassword(
        oldPassword: Textformfieldcontroller.registerpasswordcontroller.text,
        newPassword: Textformfieldcontroller.newPasswordcontroller.text,
      );
      responce.fold(
        (failure) {
          emit(ChangepasswordErrorState(message: failure));
        },
        (_) {
          emit(ChangepasswordSuccessState());
        },
      );
    } catch (e) {
      emit(ChangepasswordErrorState(message: e.toString()));
    }
  }
}
