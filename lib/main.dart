import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/auth/login.dart';
import 'package:talabat/screens/tasks.dart';
import 'package:talabat/screens/widgets/task_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Works',
      theme: ThemeData(
        primaryColor: Constant.darkblue,
      ),
      home: TaskScreen(),
    );
  }
}



