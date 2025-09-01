import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';
import 'package:todo_design_weak3/core/widgets/Button.dart';
import 'package:todo_design_weak3/core/widgets/Palestine.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/core/widgets/awesDialog.dart';
import 'package:todo_design_weak3/features/auth/cubit/register_cubit/register_cubit.dart';
import 'package:todo_design_weak3/features/auth/cubit/register_cubit/register_state.dart';
import 'package:todo_design_weak3/features/auth/widget/quesion.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  PalestineImage(),
                  Padding(
                    padding: const EdgeInsets.all(23),
                    child: SizedBox(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field cannot be empty";
                              }
                              return null;
                            },
                            controller: Textformfieldcontroller.namecontroller,
                            hintText: "Name",
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(Appicons.profile),
                            ),
                          ),
                          MyTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field cannot be empty";
                              }
                              return null;
                            },
                            controller:
                                Textformfieldcontroller.registeremailcontroller,
                            hintText: "Email",
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(Appicons.profile),
                            ),
                          ),
                          BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              final cubit = RegisterCubit.get(context);

                              return MyTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field cannot be empty";
                                  }
                                  return null;
                                },
                                controller: Textformfieldcontroller
                                    .registerpasswordcontroller,
                                obscureText: cubit.isPasswordObscure,
                                hintText: "Password",
                                prefixIcon: IconButton(
                                  onPressed: null,
                                  icon: SvgPicture.asset(Appicons.password),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<RegisterCubit>()
                                        .changePassword();
                                  },
                                  icon: cubit.isPasswordObscure
                                      ? SvgPicture.asset(Appicons.lock)
                                      : SvgPicture.asset(Appicons.unlock),
                                ),
                              );
                            },
                          ),
                          BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              final cubit = RegisterCubit.get(context);

                              return MyTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field cannot be empty";
                                  }
                                  if (value !=
                                      Textformfieldcontroller
                                          .registerpasswordcontroller
                                          .text) {
                                    return "Passwords do not match";
                                  }
                                  return null;
                                },
                                controller:
                                    Textformfieldcontroller.confirmcontroller,
                                obscureText: cubit.isConfirmObscure,
                                hintText: "Confirm Password",
                                prefixIcon: IconButton(
                                  onPressed: null,
                                  icon: SvgPicture.asset(Appicons.password),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<RegisterCubit>()
                                        .confirmchangePassword();
                                  },
                                  icon: cubit.isConfirmObscure
                                      ? SvgPicture.asset(Appicons.lock)
                                      : SvgPicture.asset(Appicons.unlock),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          BlocConsumer<RegisterCubit, RegisterState>(
                            listener: (context, state) {
                              if (state is RegisterErrorState) {
                                Message(context, "Error", state.errorMessage!);
                              } else if (state is RegisterSuccessState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Success")),
                                );

                                Navigator.of(
                                  context,
                                ).pushReplacementNamed("login");
                              }
                            },
                            builder: (context, state) {
                              if (state is RegisterLoadingState) {
                                return CircularProgressIndicator();
                              } else {
                                return MyButton(
                                  text: "Register",
                                  backgroundColor: AppColor.baseColor,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<RegisterCubit>().register();
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Quesion(
                    text: "Already Have An Account?  ",
                    text1: "Login",
                    goto: "login",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
