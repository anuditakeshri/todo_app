import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo_app/data_models/task_model.dart';
import 'package:flutter/material.dart';

class TodoModel extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<TaskModel> taskList = [];

  void sortTasks(List<TaskModel> listOfTasks) {
    listOfTasks.sort((a, b) => a.date!.compareTo(b.date!));
  }

  getAllTasks(userID) async {
    taskList = [];
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .get();
    snapshot.docs.forEach((element) {
      TaskModel taskModel = TaskModel.fromJson(
          element.data() as Map<String, dynamic>, element.id);
      taskList.add(taskModel);
    });
    sortTasks(taskList);

    notifyListeners();
  }

  deleteTaskInList(userID, taskModel, context) async {
    await _firestore
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(taskModel!.id)
        .delete();

    const snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        'Task Deleted!',
        style: TextStyle(color: Colors.red),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
    getAllTasks(userID);
  }

  addTaskInList(
      userID, taskModelId, context, title, description, datePicked) async {
    await _firestore
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(taskModelId)
        .set(
      {
        'title': title ?? '',
        'description': description ?? '',
        'date': datePicked ?? DateTime.now()
      },
    );
    const snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        'Task Saved!',
        style: TextStyle(color: Colors.red),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
    getAllTasks(userID);

    notifyListeners();
  }
}
