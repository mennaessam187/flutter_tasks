import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/widgets/Button.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/features/auth/view/loginScreen.dart';
import 'package:todo_design_weak3/features/profile/cubit/changePassword_cubit/change_cubit.dart';
import 'package:todo_design_weak3/features/profile/cubit/changePassword_cubit/change_state.dart';
import 'package:todo_design_weak3/features/profile/view/profile.dart';

class ChangepasswordScreen extends StatefulWidget {
  const ChangepasswordScreen({super.key});

  @override
  State<ChangepasswordScreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<ChangepasswordScreen> {
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
                child: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyTextFormField(
                        hintText: "Old Password",
                        controller:
                            Textformfieldcontroller.registerpasswordcontroller,
                      ),
                      MyTextFormField(
                        hintText: "New Password",
                        controller:
                            Textformfieldcontroller.newPasswordcontroller,
                      ),
                      MyTextFormField(
                        hintText: "Confirm Password",
                        controller: Textformfieldcontroller
                            .newConfirmPasswordcontroller,
                      ),
                      SizedBox(height: 15),
                      BlocConsumer<ChangePasswordCubit, ChangepasswordState>(
                        listener: (context, state) {
                          if (state is ChangepasswordSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password Changed Successfully"),
                                backgroundColor: AppColor.baseColor,
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ),
                            );
                          }
                          if (state is ChangepasswordErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password Changed Error"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return state is ChangepasswordloadingState
                              ? CircularProgressIndicator()
                              : MyButton(
                                  text: "Save",
                                  backgroundColor: Color.fromRGBO(
                                    20,
                                    153,
                                    84,
                                    1,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<ChangePasswordCubit>()
                                        .changePassword();

                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => Loginscreen(),
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
