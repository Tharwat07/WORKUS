import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/widgets/drawer.dart';
import 'package:talabat/screens/widgets/task_widget.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        drawer: DrawerW(),
        appBar: AppBar(
          backgroundColor: Constant.darkblue,
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 20,
          ),

          /* leading: Builder(
            builder: (ctx){
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
              );
            },
          ),*/
          elevation: 10,
          title: Text(
            "Tasks",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Scaffold(
            drawer: DrawerW(),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TaskWidget(
                            taskId:snapshot.data!.docs[index]['taskId'],
                            taskDescription:snapshot.data!.docs[index]['taskDescription'],
                            taskTitle:snapshot.data!.docs[index]['taskTitle'],
                            uploadedBy:snapshot.data!.docs[index]['upLoadedBy'],
                            isDone: snapshot.data!.docs[index]['isDone'],
                          );
                        });
                  } else {
                    return Center(
                      child: Text('There is no Tasks  !',
                        style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),),
                    );
                  }
                }
                return Center(child: Text("Wrong"));
              },
            )));
  }

}
