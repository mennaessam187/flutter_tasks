import 'package:todo_design_weak3/features/tasks/data/models/task_model.dart';

abstract class TaskRepo {
  addTask();
  // getTask();
  Stream<List<TaskModel>> getTask();
  deleteTask(String taskId);
  editTask(String taskId);
  doneTask();
}
