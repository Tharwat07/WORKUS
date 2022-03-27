import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';

class WorkerWedgit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {},

        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration:
          BoxDecoration(border: Border(right: BorderSide(width: 1))),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child:
            Image.network('https://flyclipart.com/thumb2/people-icons-for-free-download-878274.png',
            ),
          ),
        ),
        title: Text(
          "Worker Name",
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
              'Position/01288401432',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
        trailing: IconButton(
        icon:Icon(
          Icons.email_rounded,
          size: 30,
          color: Constant.darkblue,
        ),onPressed: (){},

        ),
      ),
    );
  }


}
