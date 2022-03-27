import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/tasks.dart';
import 'package:talabat/screens/widgets/comment_widget.dart';


class TaskDetailsScreen extends StatefulWidget {
  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  var _textstyle = TextStyle(
      color: Constant.darkblue, fontSize: 13, fontWeight: FontWeight.normal);
  var _titlesStyle = TextStyle(
      color: Constant.darkblue, fontWeight: FontWeight.bold, fontSize: 20);
  TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:IconThemeData(color: Colors.red) ,
        elevation: 8,
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextButton(
          onPressed: () {
           Navigator.pop(context);
          },
          child: Text(
            'Back',
            style: TextStyle(
                color: Constant.darkblue,
                fontStyle: FontStyle.italic,
                fontSize: 20),
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
              'Task title',
              style: TextStyle(
                  color:Constant.darkblue,
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
                          Text('Uploaded by ',
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
                                      'https://img.icons8.com/external-others-ghozy-muhtarom/344/external-person-business-smooth-others-ghozy-muhtarom-2.png'),
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
                                'Uploader name',
                                style: _textstyle,
                              ),
                              Text(
                                'Uploader job',
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
                            'Date: 20.2.2021',
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
                            'Date: 20.3.2021',
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
                          'Deadline is not finished yet',
                          style: TextStyle(
                              color: Colors.green,
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
                            onPressed: () {},
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
                            opacity: 1,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          TextButton(
                            onPressed: () {},
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
                            opacity: 0,
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
                        'Uploader job',
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
                                    borderSide:
                                    BorderSide(color: Constant.darkred),
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
                                        onPressed: () {},
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
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CommentWidget();
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                            );
                          },
                          itemCount: 15)
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
