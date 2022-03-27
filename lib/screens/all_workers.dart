import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/widgets/drawer.dart';
import 'package:talabat/screens/widgets/task_widget.dart';

import 'widgets/workers_wedgit.dart';

class AllWorkers extends StatefulWidget {
  @override
  State<AllWorkers> createState() => _AllWorkersState();
}

class _AllWorkersState extends State<AllWorkers> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: DrawerW(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 20,
          ),
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "All Workers",
            style: TextStyle(
              color: Color.fromRGBO(150, 10, 20, 1),
            ),
          ),

        ),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return WorkerWedgit();
        }));
  }

}
