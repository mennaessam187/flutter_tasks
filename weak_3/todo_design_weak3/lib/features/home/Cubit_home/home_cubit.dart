import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/features/home/Cubit_home/home_state.dart';
import 'package:todo_design_weak3/features/home/data/repo/repo_implementation.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitState());

  signOut() {
    emit(SignOutLoading());
    try {
      RepoImplementation r1 = RepoImplementation();
      r1.usersignouthome();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutError(messageError: e.toString()));
    }
  }
}
