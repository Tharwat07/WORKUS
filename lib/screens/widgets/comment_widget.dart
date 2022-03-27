import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
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
              border: Border.all(width: 2,
                  color: _colors[1]),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                    'https://img.icons8.com/external-others-ghozy-muhtarom/344/external-person-business-smooth-others-ghozy-muhtarom-2.png',
                  ),
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
                'Commenter name ',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Commenter Body  ',
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
