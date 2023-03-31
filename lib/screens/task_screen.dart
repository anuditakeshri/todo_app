import 'package:elred_todo_app/Screens/Sign_in_screen.dart';
import 'package:elred_todo_app/provider_models/user_model.dart';
import 'package:elred_todo_app/screens/invidual_task_screen.dart';
import 'package:elred_todo_app/screens/widgets/task_list.dart';
import 'package:elred_todo_app/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/dateFormatting.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: const Color(0xFFFFF1F0),
          floatingActionButton: FloatingActionButton(
            elevation: 5,
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualTaskScreen(
                    id: Provider.of<UserModel>(context, listen: false)
                        .user
                        ?.uid,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              color: Color(0xFFFFF1F0),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                'Todo Task List',
                style: TextStyle(
                    color: Color(0xFFFFF1F0),
                    fontFamily: 'LibreBaskerville',
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
              actions: [
                TextButton(
                  onPressed: () {
                    Authentication.signOut(context: context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        "Signed out",
                        style: TextStyle(color: Colors.red),
                      ),
                    ));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    "Sign out ",
                    style: TextStyle(
                        color: Color(0xFFFFF1F0),
                        fontFamily: 'LibreBaskerville',
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 225,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/redTrees.jpg'))),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.list,
                          color: Colors.white,
                          size: 40,
                        ),
                        const Text(
                          'Your tasks',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'LibreBaskerville'),
                        ),
                        Text(
                          DateFormatUtil().formatDate(DateTime.now()),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
                  child: Text(
                    'INBOX',
                    style: TextStyle(
                      color: Colors.redAccent.shade100,
                      fontSize: 18,
                    ),
                  ),
                ),
                const TaskList()
              ],
            ),
          )),
    );
  }
}
