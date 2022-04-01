import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/services/global_methods.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);
  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget>

    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _emailController =
      TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animatinStatus) {
            if (animatinStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  Future _resetPassword() async {
    showDialog (
      context: context,
      barrierDismissible: false,
      builder: (context) =>Center(
        child: CircularProgressIndicator(),
      )
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
      Fluttertoast.showToast(
          msg: "Password Reset Email Sent",
          toastLength: Toast.LENGTH_LONG,
          //gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Constant.darkblue,
          textColor: Colors.white,
          fontSize: 18.0);
      Navigator.of(context).pop();
      _emailController.clear();
    }catch (errore){
      GlobalMethods.showErrorDialog(error: '$errore', context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://i1.wp.com/www.alphr.com/wp-content/uploads/2019/06/How-to-Set-a-Linkedin-Background-Photo.jpg?fit=1000%2C666&ssl=1",
          //  placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.10,
                ),
                Text(
                  "FORGET PASSWORD ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                MaterialButton(
                  color: Colors.teal,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    _resetPassword();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
