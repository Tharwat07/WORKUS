import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/auth/login.dart';
import 'package:talabat/screens/tasks.dart';
import 'package:talabat/screens/widgets/task_widget.dart';
import 'package:talabat/user_state.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initializtion = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializtion,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Center(
                    child: Text('App is being initialized'),
                  ),
                ),
              ),
            );
          }else if (snapshot.hasError){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Center(
                    child: Text('An Error has been occured'),
                  ),
                ),
              ),
            );}
             return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Works',
              theme: ThemeData(
                primaryColor: Constant.darkblue,
              ),
              home: UserState(),
            );

          }
        );
  }
}
