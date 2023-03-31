import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? title;
  String? description;
  DateTime? date;
  String? id;

  TaskModel({
    required this.date,
    required this.description,
    required this.title,
    required this.id,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json, id) {
    Timestamp timestamp = json['date'];
    return TaskModel(
      date: timestamp.toDate(),
      title: json['title'],
      description: json['description'],
      id: (id),
    );
  }
}
