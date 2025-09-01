import 'package:flutter/material.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/features/tasks/data/models/task_model.dart';

Color colorGroub(List<TaskModel> tasks, int index) {
  if (tasks[index].groub == "Work") {
    return AppColor.workBackgroundcolor;
  } else if (tasks[index].groub == "Home") {
    return AppColor.homeBackgroundcolor;
  }
  return AppColor.personalBackgroundcolor;
}
