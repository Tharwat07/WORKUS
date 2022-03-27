import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _Titlestyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  var _contentstyle = TextStyle(
      color: Constant.darkblue, fontSize: 18, fontWeight: FontWeight.bold);
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
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              Card(
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "NAME",
                        style: _Titlestyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Job Since joined date 2022-3-24",
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
                      padding: const EdgeInsets.all(3.0),
                      child:
                          _userInfo(title: 'Email', content: 'content@gmail.com'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child:
                          _userInfo(title: 'Phone number', content: '01288401432'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _contactBy(
                            color: Colors.green,
                            fct: () {_openWhatsappChat();},
                            icon: Icons.whatsapp),
                        _contactBy(
                            color: Colors.orange,
                            fct: () {_mailTo();},
                            icon: Icons.mail_rounded),
                        _contactBy(
                            color: Colors.purple,
                            fct: () {_call();},
                            icon: Icons.call),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: MaterialButton(
                          color: Constant.darkblue,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                    height: size.width*0.20,
                    width: size.width*0.26,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 8,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://flyclipart.com/thumb2/people-icons-for-free-download-878274.png',
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
void _openWhatsappChat()async{
 String phoneNumber = '01288401432';
 var url ='https://wa.me/+2$phoneNumber?text=helloWorld';
 if  (await canLaunch(url))  {
   await launch(url);
 }
 else{
   print ('Error');
   throw 'Error Occured';
 }






}


  void _mailTo()async {
    String email = 'tharwatdev@gmail.com';
    var emailurl = 'mailto:$email';
    if (await canLaunch(emailurl)) {
      await launch(emailurl);
    }
    else {
      print('Error');
      throw 'Error Occured';
    }
  }

  void _call()async{
    String phoneNumber = '01288401432';
    var url ='tel://+2$phoneNumber';
    if  (await canLaunch(url))  {
      await launch(url);
    }
    else{
      print ('Error');
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
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            content,
            style: _contentstyle,
          ),
        ),
      ],
    );
  }
}
