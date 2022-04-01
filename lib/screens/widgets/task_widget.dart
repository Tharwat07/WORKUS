import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/inner_screens/task_details.dart';
import 'package:talabat/services/global_methods.dart';

class TaskWidget extends StatefulWidget {
  final String taskTitle;
  final String taskId;
  final String taskDescription;
  final String uploadedBy;
  final bool isDone;

  const TaskWidget(
      {required this.taskTitle,
      required this.taskId,
      required this.taskDescription,
      required this.uploadedBy,
      required this.isDone});

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailsScreen(
              taskId:widget.taskId,
              uploadBy:widget.uploadedBy ,
            )),
          );
        },
        onLongPress: () {
          _ShowDialog(context);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration:
              BoxDecoration(border: Border(right: BorderSide(width: 1))),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.network(widget.isDone
                ? 'https://img.icons8.com/flat-round/344/checkmark.png'
                : 'https://img.icons8.com/external-fauzidea-blue-fauzidea/344/external-alarm-back-to-school-fauzidea-blue-fauzidea.png'),
          ),
        ),
        title: Text(
          widget.taskTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.linear_scale_outlined, color: Constant.darkred),
            Text(
              widget.taskDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Constant.darkblue,
        ),
      ),
    );
  }

  _ShowDialog(context) {
    User? user = _auth.currentUser;
    final _uid =user!.uid;
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    if (widget.uploadedBy == _uid){
                    await FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(widget.taskId)
                        .delete();
                    Navigator.canPop(ctx) ? Navigator.pop(ctx) : null;
                    await  Fluttertoast.showToast(
                        msg: "The Task has been deleted",
                        toastLength: Toast.LENGTH_LONG,
                        // gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Constant.darkblue,
                        textColor: Colors.white,
                        fontSize: 18.0);

                    }else {
                      GlobalMethods.showErrorDialog(
                          error: 'You can\'t perform this action', context: context);
                    }
                  } catch (error) {
                    GlobalMethods.showErrorDialog(
                        error: 'This Task can\'t deleted', context: context);
                  } finally {}
                },
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
