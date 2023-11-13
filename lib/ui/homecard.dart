import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Text('Teks pertama'),
            color: Colors.blue,
            alignment: Alignment.center,
            width: 200,
            height: 200,
          )
        ],
      ),
    );
  }
}
