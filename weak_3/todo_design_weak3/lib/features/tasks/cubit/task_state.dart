import 'package:todo_design_weak3/features/tasks/data/models/task_model.dart';

class TaskState {}

class Taskinit extends TaskState {}

class AddTaskLoading extends TaskState {}

class AddTaskSuccess extends TaskState {}

class AddTaskError extends TaskState {
  String message;
  AddTaskError({required this.message});
}

class GetTaskLoding extends TaskState {}

class TaskEmpty extends TaskState {}

class GetTaskSuccessextends extends TaskState {
  List<TaskModel> task;
  GetTaskSuccessextends({required this.task});
}

class GetTaskError extends TaskState {
  String message;
  GetTaskError({required this.message});
}

class Getworktasks extends TaskState {
  List<TaskModel> task;
  Getworktasks({required this.task});
}

class Getpersonaltasks extends TaskState {
  List<TaskModel> task;
  Getpersonaltasks({required this.task});
}

class Gethometasks extends TaskState {
  List<TaskModel> task;
  Gethometasks({required this.task});
}

class TaskDeletedLoading extends TaskState {}

class TaskDeletedSuccess extends TaskState {}

class TaskDeletedError extends TaskState {}

class TaskEditError extends TaskState {}
