import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';
import 'package:todo_design_weak3/core/widgets/Button.dart';
import 'package:todo_design_weak3/core/widgets/Palestine.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/core/widgets/awesDialog.dart';
import 'package:todo_design_weak3/features/auth/cubit/logic_cubit/login_cubit.dart';
import 'package:todo_design_weak3/features/auth/cubit/logic_cubit/login_state.dart';
import 'package:todo_design_weak3/features/auth/widget/quesion.dart';
import 'package:todo_design_weak3/features/home/user_cubit/user_cubit.dart';
import 'package:todo_design_weak3/features/home/view/homeScreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PalestineImage(),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                        controller:
                            Textformfieldcontroller.loginemailcontroller,
                        hintText: "Email",
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(Appicons.profile),
                        ),
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          bool isObs = true;
                          if (state is UpdatePassword) {
                            isObs = state.initialValue;
                          }
                          return MyTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field cannot be empty";
                              }
                              return null;
                            },
                            controller:
                                Textformfieldcontroller.loginpasswordcontroller,
                            obscureText: isObs,
                            hintText: "Password",
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(Appicons.password),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<LoginCubit>().changePassword(
                                  isObs,
                                );
                              },
                              icon: isObs
                                  ? SvgPicture.asset(Appicons.lock)
                                  : SvgPicture.asset(Appicons.unlock),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),

                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is ForgetPasswordSucessState) {
                            Message(
                              context,
                              "Hint",
                              "Password reset email sent to ${Textformfieldcontroller.loginemailcontroller.text}",
                            );
                          } else if (state is ForgetPassworderorrState) {
                            Message(
                              context,
                              "Error",
                              "Error: ${state.errorMessage}",
                            );
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              context.read<LoginCubit>().forgetPasswordd();
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: AppColor.blackTextColor,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) async {
                          if (state is LoginErrorState) {
                            Message(context, "Error", state.errorMessage!);
                          } else if (state is LoginSuccessState) {
                            await FirebaseAuth.instance.currentUser?.reload();
                            User? refreshedUser =
                                FirebaseAuth.instance.currentUser;
                            await context.read<UserCubit>().getUser(
                              id: refreshedUser!.uid,
                            );
                            if (refreshedUser.emailVerified) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Homescreen(),
                                ),
                              );
                            } else {
                              Message(
                                context,
                                "Error",
                                "Please check your email and verify",
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return (state is LoginLoadingState)
                              ? Center(child: CircularProgressIndicator())
                              : MyButton(
                                  text: "Login",
                                  backgroundColor: AppColor.baseColor,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<LoginCubit>().login();
                                    }
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Quesion(
                  text: "Don’t Have An Account?   ",
                  text1: "Register",
                  goto: "ragister",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
