import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/features/home/data/repo/repo_implementation.dart';
import 'package:todo_design_weak3/features/home/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLodding());
  RepoImplementation u1 = RepoImplementation();
  getUser({String? id}) async {
    emit(UserLodding());
String userId = id ?? FirebaseAuth.instance.currentUser!.uid;
    var response = await u1.getUser(userId);
    response.fold(
      (error) => emit(UserError(message: error)),
      (user) => emit(UserSuccess(usermodel: user)),
    );
  }
}
