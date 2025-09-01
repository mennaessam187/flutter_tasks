import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';
import 'package:todo_design_weak3/features/tasks/data/repo/task_repo_implementation.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(Taskinit());
  TaskRepoImplementation t1 = TaskRepoImplementation();
  StreamSubscription? _workTasksSubscription;
  StreamSubscription? _homeTasksSubscription;
  StreamSubscription? _personalTasksSubscription;


  addTask() async {
    emit(AddTaskLoading());
    final result = await t1.addTask();
    if (result == "Task Added") {
      startAllTasksStream();
      emit(AddTaskSuccess());
    } else {
      emit(AddTaskError(message: result.toString()));
    }
  }

  StreamSubscription? _allTasksSubscription;

  
void startAllTasksStream() {
  emit(GetTaskLoding());
  _allTasksSubscription?.cancel();
  _allTasksSubscription = t1.getTask().listen(
    (tasks) {
      if (tasks.isEmpty) {
        emit(TaskEmpty());
      } else {
        final updatedTasks = tasks.map((task) {
          task.updateStatus();
          return task;
        }).toList();

        emit(GetTaskSuccessextends(task: updatedTasks));
      }
    },
    onError: (error) {
      emit(GetTaskError(message: error.toString()));
    },
  );
}

  // Future<void> fetchTasks() async {
  //   emit(GetTaskLoding());
  //   try {
  //     final tasks = await t1.getTask();
  //     if (tasks.isEmpty) {
  //       emit(TaskEmpty());
  //     } else {
  //       emit(GetTaskSuccessextends(task: tasks));
  //     }
  //   } catch (e) {
  //     emit(GetTaskError(message: e.toString()));
  //   }
  // }

  void startWorkTasksStream() {
    emit(GetTaskLoding());
    _workTasksSubscription?.cancel();
    _workTasksSubscription = t1.getWorkTasks().listen(
      (tasks) {
        emit(Getworktasks(task: tasks));
      },
      onError: (error) {
        emit(GetTaskError(message: error.toString()));
      },
    );
  }

  void startHomeTasksStream() {
    emit(GetTaskLoding());
    _homeTasksSubscription?.cancel();
    _homeTasksSubscription = t1.getHomeTasks().listen(
      (tasks) {
        emit(Gethometasks(task: tasks));
      },
      onError: (error) {
        emit(GetTaskError(message: error.toString()));
      },
    );
  }

  void startPersonalTasksStream() {
    emit(GetTaskLoding());
    _personalTasksSubscription?.cancel();
    _personalTasksSubscription = t1.getPersonalTasks().listen(
      (tasks) {
        emit(Getpersonaltasks(task: tasks));
      },
      onError: (error) {
        emit(GetTaskError(message: error.toString()));
      },
    );
  }

  void stopAllStreams() {
    _workTasksSubscription?.cancel();
    _homeTasksSubscription?.cancel();
    _personalTasksSubscription?.cancel();
  }


  deleteTask(String taskId) async {
    try {
      await t1.deleteTask(taskId);
    } catch (e) {
      emit(TaskDeletedError());
    }
  }

  updateTask(String taskId) async {
    try {
      await t1.editTask(taskId);
    } catch (e) {
      emit(TaskEditError());
    }
  }
Future<void> markTaskAsDone(String taskId) async {
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    final taskDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId);

    await taskDoc.update({
      'done': true,
      'inProgress': false,
      'missed': false,
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    throw Exception("Failed to mark task as done: $e");
  }
}

  @override
  Future<void> close() {
    stopAllStreams();
    _allTasksSubscription?.cancel();
    return super.close();
  }
}
