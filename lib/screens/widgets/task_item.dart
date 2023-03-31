import 'package:elred_todo_app/data_models/task_model.dart';
import 'package:elred_todo_app/provider_models/user_model.dart';
import 'package:elred_todo_app/screens/invidual_task_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskItem =
      TaskModel(date: DateTime.now(), description: '', title: '', id: '');

  TaskItem(this.taskItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: const CircleAvatar(
            foregroundColor: Colors.transparent,
            child: Icon(
              Icons.work,
              color: Colors.red,
              size: 15,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndividualTaskScreen(
                      id: Provider.of<UserModel>(context, listen: false)
                          .user
                          ?.uid,
                      taskModel: taskItem,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.red,
              )),
          title: Text(
            taskItem.title as String,
            style: TextStyle(
                color: Colors.red.shade600,
                fontFamily: 'Marcellus',
                fontSize: 25),
          ),
        ),
        const Divider(
          color: Color(0xFF838383),
          height: 5,
        )
      ],
    );
  }
}
