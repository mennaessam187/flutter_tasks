// class TaskModel {
//   String? title;
//   String? description;
//   String? groub;
//   String? date;
//   String? id;
//   bool inProgress=false;
//   bool missed=false;
//   bool done=false; 
//   TaskModel({
//     required this.date,
//     required this.description,
//     required this.groub,
//     required this.title,
//     required this.id,
//      this.inProgress = false,
//     this.missed = false,
//     this.done = false,
//   });

//   factory TaskModel.fromJson(Map<String, dynamic> json, String id) {
//     return TaskModel(
//       date: json["date"],
//       description: json["description"],
//       groub: json["groub"],
//       title: json["title"],
//       id: id,
//       inProgress: json["inProgress"] ?? false,
//       missed: json["missed"] ?? false,
//       done: json["done"] ?? false,
//     );
//   }
//   Map<String, dynamic> tojson() {
//     return {
//       "date": date,
//       "description": description,
//       "groub": groub,
//       "title": title,
//        "inProgress": inProgress,
//       "missed": missed,
//       "done": done,
//     };
//   }
// }
import 'package:intl/intl.dart';

class TaskModel {
  String? title;
  String? description;
  String? groub;
  String? date; 
  String? id;
  bool inProgress = false;
  bool missed = false;
  bool done = false;

  TaskModel({
    required this.date,
    required this.description,
    required this.groub,
    required this.title,
    required this.id,
    this.inProgress = false,
    this.missed = false,
    this.done = false,
  }) {
    updateStatus();
  }

  void updateStatus() {
    if (done) return;

    if (date != null && date!.isNotEmpty) {
      DateTime taskTime = DateFormat("d MMMM, yyyy h:mm a").parse(date!);
      DateTime now = DateTime.now();

      if (now.isBefore(taskTime)) {
        inProgress = true;
        missed = false;
      } else {
        inProgress = false;
        missed = true;
      }
    }
  }

  factory TaskModel.fromJson(Map<String, dynamic> json, String id) {
    return TaskModel(
      date: json["date"],
      description: json["description"],
      groub: json["groub"],
      title: json["title"],
      id: id,
      inProgress: json["inProgress"] ?? false,
      missed: json["missed"] ?? false,
      done: json["done"] ?? false,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "date": date,
      "description": description,
      "groub": groub,
      "title": title,
      "inProgress": inProgress,
      "missed": missed,
      "done": done,
    };
  }
}
