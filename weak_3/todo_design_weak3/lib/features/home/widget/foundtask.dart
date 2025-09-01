import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';
import 'package:todo_design_weak3/features/home/widget/color_groub.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';
import 'package:todo_design_weak3/features/tasks/view/homeTask_screen.dart';
import 'package:todo_design_weak3/features/tasks/view/personalTask_screen.dart';
import 'package:todo_design_weak3/features/tasks/view/todayTasks.dart';
import 'package:todo_design_weak3/features/home/widget/homecontainer.dart';
import 'package:todo_design_weak3/features/home/widget/smallContainer.dart';
import 'package:todo_design_weak3/features/home/widget/tasksgroub.dart';
import 'package:todo_design_weak3/features/tasks/view/workTask_screen.dart';

class Foundtask extends StatefulWidget {
  const Foundtask({super.key});

  @override
  State<Foundtask> createState() => _FoundtaskState();
}

class _FoundtaskState extends State<Foundtask> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Homecontainer(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TodaytasksScreen()),
              );
            },
          ),
        ),

        SizedBox(height: 10),
        BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text("In Progress"),
                  SizedBox(width: 15),
                  state is GetTaskSuccessextends
                      ? Smallcontainer(
                          fontsize: 10,
                          color: AppColor.lightgreenTextColor,
                          number: "${state.task.length}",
                          width: 15.w,
                          height: 15.h,
                        )
                      : SizedBox(),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 90,
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return state is GetTaskSuccessextends
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.task.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 250.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: colorGroub(state.task, index),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (state.task[index].groub == "Work")
                                        Text(
                                          "Work Task",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),

                                      if (state.task[index].groub == "Home")
                                        Text(
                                          "Home Task",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),

                                      if (state.task[index].groub == "Personal")
                                        Text(
                                          "Personal Task",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      if (state.task[index].groub == "Work")
                                        SvgPicture.asset(
                                          Appicons.work,
                                          width: 22.w,
                                          height: 22.h,
                                        ),
                                      if (state.task[index].groub == "Personal")
                                        SvgPicture.asset(
                                          Appicons.personal,
                                          width: 22.w,
                                          height: 22.h,
                                        ),
                                      if (state.task[index].groub == "Home")
                                        SvgPicture.asset(
                                          Appicons.home,
                                          width: 22.w,
                                          height: 22.h,
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    state.task[index].title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: state.task[index].groub == "Work"
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 20);
                        },
                      ),
                    )
                  : SizedBox();
            },
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Task Groups",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(height: 15),
        BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PersonalTasksScreen(),
                  ),
                );
              },
              child: Tasksgroub(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Appicons.personal),
                        SizedBox(width: 10),
                        Text("Personal Task"),
                        state is Getpersonaltasks
                            ? Smallcontainer(
                                width: 23.w,
                                height: 23.h,
                                color: Colors.black,
                                number: "${state.task.length}",
                                textColor: Colors.white,
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => HomeTasksScreen()));
          },
          child: Tasksgroub(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Appicons.home),

                    SizedBox(width: 10),
                    Text("Home Task"),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => WorkTasksScreen()));
          },
          child: Tasksgroub(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Appicons.work),
                    SizedBox(width: 10),
                    Text("Work Task"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
