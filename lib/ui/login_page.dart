import 'package:flutter/material.dart';
import 'package:lookup_app/ui/card_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 96),
          CardLogin(),
        ],
      ),
    ));
  }
}
