import 'package:elred_todo_app/provider_models/todo_model.dart';
import 'package:elred_todo_app/provider_models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoModel(),
        )
      ],
      builder: (context, child) => MaterialApp(
        title: 'TodoApp',
        debugShowCheckedModeBanner: false,
        home: const SignInScreen(),
        theme: ThemeData(primarySwatch: Colors.red),
      ),
    );
  }
}
