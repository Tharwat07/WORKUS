import 'package:flutter/material.dart';

import '../../inner_screens/profile.dart';

class CommentWidget extends StatefulWidget {
  final String commentId;
  final String commenterId;
  final String commenterName;
  final String commentBody;
  final String commenterImage;

  const CommentWidget(
      {required this.commentId,
      required this.commenterId,
      required this.commenterName,
      required this.commentBody,
      required this.commenterImage});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  List<Color> _colors = [
    Colors.black,
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.teal
  ];

  @override
  Widget build(BuildContext context) {
    _colors.shuffle();
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: _colors[1]),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(widget.commenterImage),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Flexible(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.commenterName,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                 widget.commentBody,
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
