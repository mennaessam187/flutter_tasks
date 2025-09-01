import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/features/auth/data/models/usermodel.dart';
import 'package:todo_design_weak3/features/home/user_cubit/user_cubit.dart';
import 'package:todo_design_weak3/features/home/user_cubit/user_state.dart';

class UpdateprofileScreen extends StatefulWidget {
  final UserModel? user;
  const UpdateprofileScreen({super.key, this.user});

  @override
  State<UpdateprofileScreen> createState() => _UpdateprofileScreenState();
}

class _UpdateprofileScreenState extends State<UpdateprofileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(Appimage.phalistineImage, width: 375),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        return state is UserSuccess
                            ? MyTextFormField(
                                hintText: "${state.usermodel.email}",
                              )
                            : CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
