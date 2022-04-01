import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/auth/login.dart';
import 'package:talabat/services/global_methods.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _passController = TextEditingController();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _positionController = TextEditingController();
  bool _vis = true;
  final _signUpKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? imageurl;
  File? imageFile;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusNode _positionFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _positionFocusNode.dispose();
    _phoneFocusNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _animationController.dispose();
    _positionController.dispose();
    _phoneController.dispose();
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

  void _submitFormOnSignUp() async {
    final isValid = _signUpKey.currentState!.validate();
    if (isValid) {
      if (imageFile == null) {
        GlobalMethods.showErrorDialog(
            error: "Please pick an image", context: context);
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim().toLowerCase(),
            password: _passController.text.trim());
        final User ?user = _auth.currentUser;
        final _uid = user!.uid;
        final ref = FirebaseStorage.instance.ref().child('userImages').child(
            _uid + '.png');
        await ref.putFile(imageFile!);
        imageurl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _nameController.text,
          'email': _emailController.text,
          'userImage': imageurl,
          'phoneNumber': _phoneController.text,
          'positionCompany': _positionController.text,
          'createAt': Timestamp.now(),
        });
        Fluttertoast.showToast(
            msg: "Registeration Succeeded",
            toastLength: Toast.LENGTH_LONG,
            //gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Constant.darkblue,
            textColor: Colors.white,
            fontSize: 18.0);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } catch (errorrr) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethods.showErrorDialog(
            error: errorrr.toString(), context: context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
            "https://i1.wp.com/www.alphr.com/wp-content/uploads/2019/06/How-to-Set-a-Linkedin-Background-Photo.jpg?fit=1000%2C666&ssl=1",
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account ?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          TextSpan(text: '   '),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),),
                            text: 'Login',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue.shade300,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _signUpKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () =>
                                    FocusScope.of(context)
                                        .requestFocus(_emailFocusNode),
                                keyboardType: TextInputType.name,
                                controller: _nameController,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return "This field is missing";
                                  else
                                    return null;
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Full Name",
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          width: 1, color: Colors.white),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: imageFile == null
                                          ? Image.network(
                                        'https://img.icons8.com/external-others-ghozy-muhtarom/344/external-person-business-smooth-others-ghozy-muhtarom-2.png',
                                        height: size.width * 0.24,
                                        width: size.width * 0.24,
                                        fit: BoxFit.fill,
                                      )
                                          : Image.file(
                                        imageFile!,
                                        height: size.width * 0.24,
                                        width: size.width * 0.24,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      _showImageDialog();
                                    },
                                    child: Container(
                                      height: size.width * 0.09,
                                      width: size.width * 0.09,
                                      decoration: BoxDecoration(
                                        color: Constant.darkred,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                      ),
                                      child: Icon(
                                        imageFile == null
                                            ? Icons.add_a_photo
                                            : Icons.edit_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@'))
                              return "Please enter a valid Email";
                            else
                              return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context)
                                  .requestFocus(_phoneFocusNode),
                          focusNode: _passFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _vis,
                          controller: _passController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7)
                              return "Please enter a valid Password";
                            else
                              return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _vis = !_vis;
                                });
                              },
                              child: Icon(
                                _vis ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context)
                                  .requestFocus(_positionFocusNode),
                          keyboardType: TextInputType.phone,
                          focusNode: _phoneFocusNode,
                          controller: _phoneController,
                          validator: (value) {
                            if (value!.isEmpty)
                              return "This field is missing";
                            else
                              return null;
                          },
                          onChanged: (value) {},
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Phone number",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _ShowjobsDialog(size: size);
                          },
                          child: TextFormField(
                            enabled: false,
                            textInputAction: TextInputAction.done,
                            focusNode: _positionFocusNode,
                            keyboardType: TextInputType.name,
                            controller: _positionController,
                            validator: (value) {
                              if (value!.isEmpty)
                                return "This field is missing";
                              else
                                return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Potition in the company ",
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _isLoading
                      ? Center(
                       child: Container(
                       child: CircularProgressIndicator(),
                    ),
                  )
                      : MaterialButton(
                    color: Constant.darkred,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      _submitFormOnSignUp();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1000,
      maxHeight: 10000,
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  void _ShowjobsDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "Choose your job",
              style: TextStyle(
                  fontSize: 20,
                  color: Constant.darkblue,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: size.width * 0.2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Constant.jobList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _positionController.text = Constant.jobList[index];
                      });
                      Navigator.pop(context);
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
                          child: Text(Constant.jobList[index],
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
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please choose an option'),
            content: Container(
              height: 100,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _getFromCamera();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Constant.darkred,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Camera',
                            style: TextStyle(color: Constant.darkred),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _getFromGallery();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image_rounded,
                            color: Constant.darkred,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Gallery',
                            style: TextStyle(color: Constant.darkred),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);

    /*setState(() {
      imageFile = File(pickedFile!.path);
    });*/
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    /*setState(() {
      imageFile = File(pickedFile!.path);
    });*/
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }
}
