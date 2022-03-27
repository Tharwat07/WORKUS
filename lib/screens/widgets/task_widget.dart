import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/inner_screens/task_details.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailsScreen()),
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
            child: Image.network(
              'https://image.shutterstock.com/image-vector/check-mark-brushed-600w-399970768.jpg',
            ),
          ),
        ),
        title: Text(
          "Title",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.linear_scale_outlined,
              color: Color.fromRGBO(150, 10, 20, 1),
            ),
            Text(
              'Subtitle/task descriptionSubtitle/task descriptionSubtitle/task descriptionSubtitle/task descriptionSubtitle/task descriptionSubtitle/task descriptionSubtitle/task descriptionSubtitle/task descriptionSubtitle/task ',
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
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {},
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
