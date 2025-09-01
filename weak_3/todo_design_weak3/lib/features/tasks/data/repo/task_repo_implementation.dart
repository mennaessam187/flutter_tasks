import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/features/tasks/data/models/task_model.dart';
import 'package:todo_design_weak3/features/tasks/data/repo/task_repo.dart';

class TaskRepoImplementation extends TaskRepo {
  @override
  Future<String> addTask() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        return "User not logged in";
      }
      final userTaskCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks');

      await userTaskCollection.add({
        'title': Textformfieldcontroller.titlecontroller.text,
        'description': Textformfieldcontroller.discriptioncontroller.text,
        'date': Textformfieldcontroller.endtimecontroller.text,
        'groub': Textformfieldcontroller.groubcontroller.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return "Task Added";
    } catch (error) {
      return error.toString();
    }
  }

  Stream<List<TaskModel>> getHomeTasks() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .where('groub', isEqualTo: 'Home')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }

  Stream<List<TaskModel>> getWorkTasks() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .where('groub', isEqualTo: 'Work')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }

  Stream<List<TaskModel>> getPersonalTasks() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .where('groub', isEqualTo: 'Personal')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }

  @override
  Future<void> deleteTask(String taskId) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  @override
  doneTask() {}

  @override
  Future<void> editTask(String taskId) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      final userTaskCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId);

      await userTaskCollection.update({
        'title': Textformfieldcontroller.titlecontroller.text,
        'description': Textformfieldcontroller.discriptioncontroller.text,
        'date': Textformfieldcontroller.endtimecontroller.text,
        'groub': Textformfieldcontroller.groubcontroller.text,
        'UpdatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      throw Exception('Failed to delete task: $error');
    }
  }

  Stream<List<TaskModel>> getTask() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }
}
//   @override
//   Future<List<TaskModel>> getTask() async {
//     try {
//       final uid = FirebaseAuth.instance.currentUser?.uid;
//       if (uid == null) {
//         throw Exception("User not logged in");
//       }

//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(uid)
//           .collection('tasks')
//           .get();

//       List<TaskModel> tasks = snapshot.docs.map((doc) {
//         return TaskModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();

//       return tasks;
//     } catch (e) {
//       throw Exception("Error loading tasks: $e");
//     }
//   }
// }

