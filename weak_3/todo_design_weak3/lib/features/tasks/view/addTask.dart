import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/widgets/Button.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/core/widgets/awesDialog.dart';
import 'package:todo_design_weak3/features/taskGroub/widget/groubTextFormField.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';
import 'package:todo_design_weak3/features/tasks/cubit/image_cubit/image_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/image_cubit/image_State.dart';
import 'package:image_picker/image_picker.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, String>? selectedGroup;
  @override
  void initState() {
    Textformfieldcontroller.titlecontroller.clear();
    Textformfieldcontroller.discriptioncontroller.clear();
    Textformfieldcontroller.endtimecontroller.clear();
    Textformfieldcontroller.groubcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Add Task",
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 15),
                    BlocBuilder<ImageCubit, ImageState>(
                      builder: (context, state) {
                        final imageCubit = context.read<ImageCubit>();
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => Container(
                                height: 120,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text("Gallery"),
                                      onTap: () {
                                        imageCubit.pickImage(
                                          ImageSource.gallery,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text("Camera"),
                                      onTap: () {
                                        imageCubit.pickImage(
                                          ImageSource.camera,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 261,
                            height: 207,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: (state is ImagePickedSuccess)
                                    ? FileImage(state.image) as ImageProvider
                                    : AssetImage(Appimage.phalistineImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    MyTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      hintText: "Title",
                      controller: Textformfieldcontroller.titlecontroller,
                    ),
                    SizedBox(height: 15),
                    MyTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
                      hintText: "Description",
                      controller: Textformfieldcontroller.discriptioncontroller,
                    ),
                    SizedBox(height: 15),
                    Groubtextformfield(),
                    SizedBox(height: 15),
                    MyTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field cannot be empty";
                        }
                        return null;
                      },
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
                    SizedBox(height: 15),
                    BlocConsumer<TaskCubit, TaskState>(
                      listener: (context, state) async {
                        if (state is AddTaskSuccess) {
                          final imageCubit = context.read<ImageCubit>();
                          if (imageCubit.pickedImage != null) {
                            await imageCubit.uploadImage("task_id_here");
                          }

                          Navigator.of(context).pushReplacementNamed("home");
                        } else if (state is AddTaskError) {
                          Message(context, "Error", state.message);
                        }
                      },
                      builder: (context, state) {
                        return MyButton(
                          text: "Add Task",
                          backgroundColor: AppColor.baseColor,
                          onPressed: () {
                            context.read<TaskCubit>().addTask();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
