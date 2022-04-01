import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talabat/screens/auth/login.dart';
import 'package:talabat/screens/tasks.dart';
class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('User is not signed in yet');
            return Login();
          } else if (userSnapshot.hasData) {
            print('User is already signed in ');
            return TaskScreen();
          } else if (userSnapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error has Occured'),
              ),
            );
          }
          else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        }

    );
  }
}
