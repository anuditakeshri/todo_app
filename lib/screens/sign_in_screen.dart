import 'package:elred_todo_app/screens/widgets/sign_in_button.dart';
import 'package:elred_todo_app/utils/authentication.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/elRed_logo.png',
                        height: 160,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Network of Networks',
                      style: TextStyle(
                          color: Color(0xFF838383),
                          fontSize: 20,
                          fontFamily: 'LibreBaskerville'),
                    ),
                    const Text(
                      'Leveraging all connections',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LibreBaskerville'),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    FutureBuilder(
                      future:
                          Authentication.initializeFirebase(context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Error initializing Firebase');
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return GoogleSignInButton();
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
