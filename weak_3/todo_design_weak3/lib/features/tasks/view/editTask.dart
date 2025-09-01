import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/widgets/Button.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/features/taskGroub/widget/groubTextFormField.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';
import 'package:todo_design_weak3/features/tasks/data/models/task_model.dart';
import 'package:todo_design_weak3/features/tasks/view/todayTasks.dart';

class Edittask extends StatefulWidget {
  final TaskModel? task;
  const Edittask({super.key, this.task});

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      Textformfieldcontroller.groubcontroller.text = widget.task!.groub ?? "";
      Textformfieldcontroller.titlecontroller.text = widget.task!.title ?? "";
      Textformfieldcontroller.discriptioncontroller.text =
          widget.task!.description ?? "";
      Textformfieldcontroller.endtimecontroller.text = widget.task!.date ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(228, 49, 43, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: BlocBuilder<TaskCubit, TaskState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () {
                            context.read<TaskCubit>().deleteTask(
                              widget.task!.id!,
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => TodaytasksScreen(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white, size: 20),
                              Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
          title: Text(
            "Edit Task",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 15),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(Appimage.phalistineImage),
                      child: ClipRRect(),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("In Progress"),
                        Container(
                          width: 220,
                          child: Text(
                            widget.task!.title!,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Groubtextformfield(),
                SizedBox(height: 15),
                MyTextFormField(
                  hintText: "Title",
                  controller: Textformfieldcontroller.titlecontroller,
                ),
                SizedBox(height: 15),
                MyTextFormField(
                  hintText: "Description",
                  controller: Textformfieldcontroller.discriptioncontroller,
                ),

                SizedBox(height: 15),
                MyTextFormField(
                  controller: Textformfieldcontroller.endtimecontroller,
                  readonly: true,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        final DateTime finalDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        final formatted = DateFormat(
                          "d MMMM, yyyy h:mm a",
                        ).format(finalDateTime);

                        Textformfieldcontroller.endtimecontroller.text =
                            formatted;
                      }
                    }
                  },

                  hintText: "End Time",
                  prefixIcon: Icon(
                    Icons.calendar_month_rounded,
                    color: AppColor.baseColor,
                  ),
                ),
                SizedBox(height: 91),
                // MyButton(
                //   text: "Mark as Done",
                //   backgroundColor: AppColor.baseColor,
                //   onPressed: () {
                //     Navigator.of(context).pushReplacementNamed("login");
                //   },
                // ),
                MyButton(
                  text: "Mark as Done",
                  backgroundColor: AppColor.baseColor,
                  onPressed: () async {
                    try {
                      // استدعاء دالة markTaskAsDone في TaskCubit
                      await context.read<TaskCubit>().markTaskAsDone(
                        widget.task!.id!,
                      );

                      context.read<TaskCubit>().startAllTasksStream();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task marked as done!")),
                      );

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => TodaytasksScreen(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to mark task as done")),
                      );
                    }
                  },
                ),

                SizedBox(height: 22),
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    return MyButton(
                      backgroundColor: AppColor.buttonTextColor,
                      text: "Update",
                      onPressed: () {
                        context.read<TaskCubit>().updateTask(widget.task!.id!);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => TodaytasksScreen(),
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
      ),
    );
  }
}
