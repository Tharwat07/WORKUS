import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/tasks.dart';
import 'package:talabat/screens/widgets/comment_widget.dart';
import 'package:talabat/services/global_methods.dart';
import 'package:uuid/uuid.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({
    required this.uploadBy,
    required this.taskId,
  });

  final String uploadBy;
  final String taskId;

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  var _textstyle = TextStyle(
      color: Constant.darkblue, fontSize: 18, fontWeight: FontWeight.normal);
  var _titlesStyle = TextStyle(
      color: Constant.darkblue, fontWeight: FontWeight.bold, fontSize: 20);
  TextEditingController _commentController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCommenting = false;
  String? authorName;
  String? authorPosition;
  String? taskCategory;
  String? taskDescription;

  String? commenterID;
  String? commentername;
  String? commenterImage;

  String? taskTitle;
  String? image;
  bool? _isDone;

  Timestamp? postedDateTimeStamp;
  Timestamp? deadlineTimeStamp;
  String? postedDate;
  String? deadlineDate;

  bool isDeadlineAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaskDate();
  }

  void getTaskDate() async {
    try {
      final User? user = _auth.currentUser;
      final String _uid = user!.uid;
      final DocumentSnapshot currentuserDoc =
      await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      setState(() {
        commenterID = _auth.currentUser!.uid;
        commentername = currentuserDoc.get('name');
        commenterImage = currentuserDoc.get('userImage');
      });

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uploadBy)
        .get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        authorName = userDoc.get('name');
        authorPosition = userDoc.get('positionCompany');
        image = userDoc.get('userImage');
      });
    }
    final DocumentSnapshot taskDB = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.taskId)
        .get();

    if (taskDB == null) {
      return;
    } else {
      setState(() {
        taskDescription = taskDB.get('taskDescription');
        taskTitle = taskDB.get('taskTitle');
        _isDone = taskDB.get('isDone');
        postedDateTimeStamp = taskDB.get('createdAt');
        deadlineTimeStamp = taskDB.get('daedLineDateTimeStamp');
        deadlineDate = taskDB.get('deadLineDate');
        var postDate = postedDateTimeStamp!.toDate();
        postedDate = '${postDate.year}-${postDate.month}-${postDate.day}';
        var date = deadlineTimeStamp!.toDate();
        isDeadlineAvailable = date.isAfter(DateTime.now());

      });

    }
  }catch (error){
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal),
        elevation: 8,
        automaticallyImplyLeading: true,
        backgroundColor: Constant.darkblue,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back',
            style: TextStyle(
                color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              taskTitle == null ? '' : taskTitle!,
              style: TextStyle(
                  color: Constant.darkblue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Uploaded By ',
                              style: TextStyle(
                                  color: Constant.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.amber,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    image == null
                                        ? 'https://img.icons8.com/external-others-ghozy-muhtarom/344/external-person-business-smooth-others-ghozy-muhtarom-2.png'
                                        : image!,
                                  ),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authorName == null ? '' : authorName!,
                                style: _textstyle,
                              ),
                              Text(
                                authorPosition == null ? '' : authorPosition!,
                                style: _textstyle,
                              ),
                            ],
                          )
                        ],
                      ),
                      dividerWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Uploaded on:',
                            style: _titlesStyle,
                          ),
                          Text(
                            postedDate == null ? '' : postedDate!,
                            style: TextStyle(
                                color: Constant.darkblue,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Deadline date:',
                            style: _titlesStyle,
                          ),
                          Text(
                            deadlineDate == null ? '' : deadlineDate!,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          isDeadlineAvailable
                              ? 'Deadline is not finished yet'
                              : 'Deadline Passed',
                          style: TextStyle(
                              color: isDeadlineAvailable
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      dividerWidget(),
                      Text(
                        'Done state:',
                        style: _titlesStyle,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              User? user = _auth.currentUser;
                              final _uid = user!.uid;
                              if (_uid == widget.uploadBy) {
                                try {
                                  FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(widget.taskId)
                                      .update({'isDone': true});
                                } catch (error) {}
                              } else {
                                GlobalMethods.showErrorDialog(
                                    error: 'Action can\'t be performed',
                                    context: context);
                              }
                              getTaskDate();
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                  color: Constant.darkblue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Opacity(
                            opacity: _isDone == true ? 1 : 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          TextButton(
                            onPressed: () {
                              User? user = _auth.currentUser;
                              final _uid = user!.uid;
                              if (_uid == widget.uploadBy) {
                                try {
                                  FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(widget.taskId)
                                      .update({'isDone': false});
                                } catch (error) {}
                              } else {
                                GlobalMethods.showErrorDialog(
                                    error: 'Action can\'t be performed',
                                    context: context);
                              }
                              getTaskDate();
                            },
                            child: Text(
                              'Not Done',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                  color: Constant.darkblue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Opacity(
                            opacity: _isDone == false ? 1 : 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      dividerWidget(),
                      Text(
                        'Task Description:',
                        style: _titlesStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        taskDescription == null ? '' : taskDescription!,
                        style: _textstyle,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      AnimatedSwitcher(
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        child: _isCommenting
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: TextField(
                                      controller: _commentController,
                                      style:
                                          TextStyle(color: Constant.darkblue),
                                      maxLength: 200,
                                      keyboardType: TextInputType.text,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Constant.darkred),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            if (_commentController
                                                    .text.length ==
                                                0) {
                                              GlobalMethods.showErrorDialog(
                                                  error:
                                                      'Comment mustn\'t be empty',
                                                  context: context);
                                            } else {

                                              final _generateId = Uuid().v4();
                                              await FirebaseFirestore.instance
                                                  .collection('tasks')
                                                  .doc(widget.taskId)
                                                  .update({
                                                'taskComment':
                                                    FieldValue.arrayUnion([
                                                  {
                                                    'userId':commenterID,
                                                    'commentId': _generateId,
                                                    'name': commentername,
                                                    'image': commenterImage,
                                                    'commentBody':
                                                        _commentController.text,
                                                    'time': Timestamp.now(),
                                                  }
                                                ])
                                              });
                                              await Fluttertoast.showToast(
                                                  msg:
                                                      "Your comment has been posted",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  // gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor:
                                                      Constant.darkblue,
                                                  textColor: Colors.white,
                                                  fontSize: 18.0);
                                              _commentController.clear();
                                            }
                                            setState(() {

                                            });

                                          },
                                          color: Constant.darkred,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            'Post',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _isCommenting = !_isCommenting;
                                            });
                                          },
                                          child: Text('Cancel'))
                                    ],
                                  ))
                                ],
                              )
                            : Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCommenting = !_isCommenting;
                                    });
                                  },
                                  color: Constant.darkred,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Text(
                                      'Add a Comment',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('tasks')
                              .doc(widget.taskId)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (snapshot.data == null) {
                                Center(
                                    child: Text(
                                  'No Commentes has been added for this task. Be the first one !',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ));
                              }
                            }
                            return ListView.separated(
                                shrinkWrap: true,
                                reverse: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CommentWidget(
                                    commenterImage: snapshot.data!['taskComment'][index]['image'],
                                    commentId: snapshot.data!['taskComment'][index]['commentId'],
                                    commentBody: snapshot.data!['taskComment'][index]['commentBody'],
                                    commenterName : snapshot.data!['taskComment'][index]['name'],
                                    commenterId: snapshot.data!['taskComment'][index]['userId'],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    thickness: 1,
                                  );
                                },
                                itemCount:
                                    snapshot.data!['taskComment'].length);
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dividerWidget() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
