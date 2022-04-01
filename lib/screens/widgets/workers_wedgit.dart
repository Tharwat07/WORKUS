import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/inner_screens/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerWedgit extends StatelessWidget {
  final String userID;
  final String userName;
  final String userEmail;
  final String positionCompany;
  final String phoneNumber;
  final String image;
  const WorkerWedgit({
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.positionCompany,
    required this.phoneNumber,
    required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
              builder: (context) => ProfileScreen(userID:userID ,),
          ),
          );
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
             image == null? 'https://flyclipart.com/thumb2/people-icons-for-free-download-878274.png':image,
            ),
          ),
        ),
        title: Text(
          userName,
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
              color: Constant.darkred,
            ),
            Text(
              '$positionCompany/$phoneNumber',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.email_rounded,
            size: 30,
            color: Constant.darkblue,
          ),
          onPressed: _mailTo
        ),
      ),
    );
  }
  void _mailTo() async {
    var emailurl = 'mailto:$userEmail';
    if (await canLaunch(emailurl)) {
      await launch(emailurl);
    } else {
      print('Error');
      throw 'Error Occured';
    }
  }

}
