import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/auth/login.dart';
import 'package:talabat/screens/widgets/drawer.dart';
import 'package:talabat/user_state.dart';
import 'package:url_launcher/url_launcher.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.userID});
  final String userID;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  var _Titlestyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  var _contentstyle = TextStyle(
      color: Constant.darkblue, fontSize: 18, fontWeight: FontWeight.bold);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String phoneNumber = "";
  String email = "";
  String name = "";
  String job = "";
  String image = "";
  String joinedAt = "";
  bool _isSameUser = false;
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.darkblue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 8,
        automaticallyImplyLeading: true,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 25),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    Card(
                      shadowColor: Colors.black,
                        color: Colors.blueGrey[300],
                        margin: EdgeInsets.only(top: 30,right:10 ,left:10,bottom: 30 ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                name,
                                style: _Titlestyle,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "$job ",
                                style: _contentstyle,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Joined since $joinedAt",
                                style: _contentstyle,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Contact Info",
                              style: _Titlestyle,
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: _userInfo(title: 'Email:', content: email),
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: _userInfo(
                                  title: 'Phone number:', content: phoneNumber),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            _isSameUser
                                ? Container()
                                : Divider(
                                    thickness: 1,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            _isSameUser
                                ? Container()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _contactBy(
                                          color: Colors.green,
                                          fct: () {
                                            _openWhatsappChat();
                                          },
                                          icon: Icons.whatsapp),
                                      _contactBy(
                                          color: Colors.orange,
                                          fct: () {
                                            _mailTo();
                                          },
                                          icon: Icons.mail_rounded),
                                      _contactBy(
                                          color: Colors.purple,
                                          fct: () {
                                            _call();
                                          },
                                          icon: Icons.call),
                                    ],
                                  ),
                            SizedBox(
                              height: 30,
                            ),
                            !_isSameUser
                                ? Container()
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 30),
                                      child: MaterialButton(
                                        color: Constant.darkred,
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        onPressed: () {
                                          _auth.signOut();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UserState(),
                                            ),
                                          );

                                          Navigator.canPop(context)
                                              ? Navigator.pop(context)
                                              : null;

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.logout,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "Logout",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.width * 0.26,
                          width: size.width * 0.26,
                          decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            image: DecorationImage(
                                image: NetworkImage(
                                  image == null
                                      ? 'https://flyclipart.com/thumb2/people-icons-for-free-download-878274.png'
                                      : image,
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void getData() async {
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      if (userDoc == null) {
        print("ERRORR ");
      } else {
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
          job = userDoc.get('positionCompany');
          phoneNumber = userDoc.get('phoneNumber');
          image = userDoc.get('userImage');
          Timestamp joidedAtTimeStemp = userDoc.get('createAt');
          var joinedDate = joidedAtTimeStemp.toDate();
          joinedAt = '${joinedDate.year}-${joinedDate.month}-${joinedDate.day}';
        });
        User? user = _auth.currentUser;
        final _uid = user!.uid;
        setState(() {
          _isSameUser = _uid == widget.userID;
        });
      }
    } catch (error) {
    } finally {
      _isLoading = false;
    }
  }

  void _openWhatsappChat() async {
    var url = 'https://wa.me/+2$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Error');
      throw 'Error Occured';
    }
  }

  void _mailTo() async {
    var emailurl = 'mailto:$email';
    if (await canLaunch(emailurl)) {
      await launch(emailurl);
    } else {
      print('Error');
      throw 'Error Occured';
    }
  }

  void _call() async {
    var url = 'tel://+2$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Error');
      throw 'Error Occured';
    }
  }

  Widget _contactBy(
      {required Color color, required Function fct, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: () {
            fct();
          },
          icon: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _userInfo({required String title, required String content}) {
    return Row(
      children: [
        Text(
          title,
          style: _Titlestyle,
        ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              content,
              style: _contentstyle,
            ),
          ),
      ],
    );
  }
}
