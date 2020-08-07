import 'package:flutter/material.dart';

class BoardCard extends StatelessWidget {
  final int id;
  final String text;

  BoardCard({@required this.id, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ID: $id',
            style: TextStyle(fontSize: 11),
          ),
          SizedBox(height: 7),
          Text(text),
        ],
      ),
    );
  }
}
