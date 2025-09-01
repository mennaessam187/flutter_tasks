import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/helper/Dialog.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/widgets/awesDialog.dart';
import 'package:todo_design_weak3/features/home/view/homeScreen.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';
import 'package:todo_design_weak3/core/widgets/searchTextFormField.dart';
import 'package:todo_design_weak3/features/home/widget/smallContainer.dart';
import 'package:todo_design_weak3/features/tasks/view/editTask.dart';

Future<Map<String, String>?> finallyyyyyy(BuildContext context) {
  return showDialog<Map<String, String>>(
    context: context,
    barrierDismissible: true,
    builder: (context) => const TaskFilterDialog(),
  );
}

class TodaytasksScreen extends StatefulWidget {
  const TodaytasksScreen({super.key});

  @override
  State<TodaytasksScreen> createState() => _TodaytasksScreenState();
}

class _TodaytasksScreenState extends State<TodaytasksScreen> {
  String selectedStatus = 'All';
  String selectedCategory = 'All';
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..startAllTasksStream(),
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.baseColor,
            shape: const CircleBorder(),
            onPressed: () async {
              final result = await finallyyyyyy(context);
              if (result != null) {
                final category = result['category'];
                final status = result['status'];

                setState(() {
                  selectedCategory = category ?? 'All';
                  selectedStatus = status ?? 'All';
                });

                final taskCubit = context.read<TaskCubit>();

                if (selectedCategory == 'All') {
                  taskCubit.startAllTasksStream();
                } else if (selectedCategory == 'Work') {
                  taskCubit.startWorkTasksStream();
                } else if (selectedCategory == 'Home') {
                  taskCubit.startHomeTasksStream();
                } else if (selectedCategory == 'Personal') {
                  taskCubit.startPersonalTasksStream();
                }
              }
            },
            child: SvgPicture.asset(Appicons.Filter),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Homescreen()),
                );
              },
              icon: Icon(Icons.arrow_back_ios, size: 15),
            ),
            centerTitle: true,
            title: Text(
              "Tasks",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
            ),
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BlocConsumer<TaskCubit, TaskState>(
                listener: (context, state) {
                  if (state is GetTaskError) {
                    Message(context, "error", state.message);
                  }
                },
                builder: (context, state) {
                  if (state is GetTaskSuccessextends) {
                    
                    final filteredTasks = state.task.where((task) {
                      bool matchesCategory = true;
                      bool matchesStatus = true;
                      bool matchesSearch = true;

                      if (selectedCategory != 'All') {
                        matchesCategory = task.groub == selectedCategory;
                      }

                      if (selectedStatus != 'All') {
                        if (selectedStatus == 'Done') {
                          matchesStatus = task.done;
                        } else if (selectedStatus == 'In Progress') {
                          matchesStatus = task.inProgress;
                        } else if (selectedStatus == 'Missed') {
                          matchesStatus = task.missed;
                        }
                      }

                      if (searchQuery.isNotEmpty) {
                        matchesSearch =
                            task.title?.toLowerCase().contains(
                              searchQuery.toLowerCase(),
                            ) ??
                            false;
                      }

                      return matchesCategory && matchesStatus && matchesSearch;
                    }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Searchtextformfield(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Text(
                              "Results",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 30),
                            Smallcontainer(
                              width: 25.w,
                              height: 25.h,
                              color: const Color.fromRGBO(20, 153, 84, 0.15),
                              fontsize: 15,
                              number: filteredTasks.length.toString(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredTasks.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final task = filteredTasks[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Edittask(task: task),
                                  ),
                                );
                              },
                              child: buildTaskItem(task),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is TaskEmpty) {
                    return const Center(child: Text("No Task In Store!"));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTaskItem(task) {
    return Center(
      child: Container(
        width: 334.w,
        height: 95.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 10, top: 10),
          child: Row(
            children: [
              Container(
                height: 70.h,
                width: 100.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    Appimage.phalistineImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 150.w,
                      child: Text(
                        task.title ?? "No Title",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Row(
                children: [
                  if (task.done)
                    statusChip("Done", AppColor.baseColor)
                  else if (task.inProgress)
                    statusChip("In Progress", AppColor.personalBackgroundcolor)
                  else if (task.missed)
                    statusChip("Missed", Colors.redAccent),
                  const SizedBox(width: 20),
                  if (task.groub == "Work")
                    SvgPicture.asset(Appicons.work, width: 25, height: 25),
                  if (task.groub == "Home")
                    SvgPicture.asset(Appicons.home, width: 25, height: 25),
                  if (task.groub == "Personal")
                    SvgPicture.asset(Appicons.personal, width: 25, height: 25),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusChip(String text, Color color) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
