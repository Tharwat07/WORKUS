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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: DrawerW(),
        appBar: AppBar(
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
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Tasks",
            style: TextStyle(
              color: Color.fromRGBO(150, 10, 20, 1),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _ShowTaskCategoryDialog(size: size);
              },
              icon: Icon(Icons.filter_list_outlined),
              color: Colors.white,
            )
          ],
        ),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return TaskWidget();
        }));
  }

  _ShowTaskCategoryDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Task Category",
              style: TextStyle(
                  fontSize: 20,
                  color: Constant.darkblue,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: size.width * 0.2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Constant.taskCatigoryList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      print('TaskCategoryList, ${Constant.taskCatigoryList[index]}');
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Constant.darkblue,
                        ),
                        //  SizedBox(width:10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(Constant.taskCatigoryList[index],
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: Constant.darkblue,
                              )),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Close'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Cancel filter'),
              ),
            ],
          );
        });
  }
}
