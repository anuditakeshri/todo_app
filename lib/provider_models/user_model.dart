import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elred_todo_app/screens/task_screen.dart';
import 'package:elred_todo_app/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  User? user;
  bool isLoading = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<bool> isNewUser(User user) async {
    bool isNewUser = false;
    await users.doc(user.uid).get().then((value) {
      isNewUser = value.exists;
      print(value.exists);
    });

    return isNewUser;
  }

  signIn(context) async {
    isLoading = true;
    notifyListeners();

    User? user = await Authentication.signInWithGoogle(context: context);

    isLoading = false;
    notifyListeners();

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "Signed in as ${user.email}",
          style: const TextStyle(color: Colors.red),
        ),
      ));
      setUser(user);
      if (!await isNewUser(user)) {
        await addUser(user);
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TaskScreen()));
    }
  }

  Future<void> addUser(User user) {
    return users
        .doc(user.uid)
        .set({'name': user.displayName, 'email': user.email})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  setUser(User userData) {
    user = userData;
    notifyListeners();
  }
}
