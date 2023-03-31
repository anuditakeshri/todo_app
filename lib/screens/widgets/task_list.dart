import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo_app/provider_models/todo_model.dart';
import 'package:elred_todo_app/screens/invidual_task_screen.dart';
import 'package:elred_todo_app/screens/widgets/task_item.dart';
import 'package:elred_todo_app/provider_models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    Provider.of<TodoModel>(context, listen: false)
        .getAllTasks(Provider.of<UserModel>(context, listen: false).user?.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(builder: (context, todoModel, child) {
      if (todoModel.taskList.isEmpty) {
        return Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 4.5),
          child: const Center(
            child: Text(
              'No tasks yet',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'LibreBaskerville',
                  color: Color(0xFF838383),
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return TaskItem(todoModel.taskList[index]);
            },
            itemCount: todoModel.taskList.length,
          ),
        );
      }
    });
  }
}
