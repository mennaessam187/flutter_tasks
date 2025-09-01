import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/appBar.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/widgets/awesDialog.dart';
import 'package:todo_design_weak3/core/widgets/loding.dart';
import 'package:todo_design_weak3/features/auth/cubit/logic_cubit/login_cubit.dart';
import 'package:todo_design_weak3/features/home/Cubit_home/home_cubit.dart';
import 'package:todo_design_weak3/features/home/Cubit_home/home_state.dart';
import 'package:todo_design_weak3/features/home/widget/foundtask.dart';
import 'package:todo_design_weak3/features/home/widget/noTasks.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HomeCubit()),

        BlocProvider(create: (context) => TaskCubit()..startAllTasksStream()),
      ],
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.baseColor,
            shape: CircleBorder(),
            onPressed: () {
              Navigator.of(context).pushNamed("addTask");
            },
            child: Icon(Icons.note_add_outlined, color: Colors.white),
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Appbarw(),
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {
                        if (state is SignOutSuccess) {
                          Navigator.of(
                            context,
                          ).pushNamedAndRemoveUntil("login", (route) => false);
                        } else if (state is SignOutError) {
                          Message(
                            context,
                            "Error",
                            "Field To SignOut Try Again!",
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is SignOutLoading
                            ? CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  Textformfieldcontroller
                                      .loginpasswordcontroller
                                      .clear();
                                  Textformfieldcontroller.loginemailcontroller
                                      .clear();
                                  Textformfieldcontroller
                                      .registeremailcontroller
                                      .clear();
                                  Textformfieldcontroller
                                      .registerpasswordcontroller
                                      .clear();
                                  Textformfieldcontroller.namecontroller
                                      .clear();
                                  Textformfieldcontroller.confirmcontroller
                                      .clear();
                                  context.read<HomeCubit>().signOut();
                                },
                                icon: Icon(
                                  Icons.exit_to_app,
                                  color: AppColor.baseColor,
                                ),
                              );
                      },
                    ),
                  ],
                ),
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    if (state is GetTaskLoding) {
                      return LoddingState();
                    } else if (state is GetTaskSuccessextends) {
                      return Foundtask();
                    } else if (state is TaskEmpty) {
                      return Notasks();
                    } else if (state is AddTaskError) {
                      return Center(child: Text("Error: ${state.message}"));
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
