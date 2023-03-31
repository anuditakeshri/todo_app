import 'package:elred_todo_app/screens/task_screen.dart';
import 'package:elred_todo_app/provider_models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Consumer<UserModel>(builder: (context, userModel, child) {
          if (userModel.isLoading) {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            );
          } else {
            return OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                Provider.of<UserModel>(context, listen: false).signIn(context);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage("assets/images/google_logo.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        }));
  }
}
