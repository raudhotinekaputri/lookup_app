import 'package:flutter/material.dart';
import 'package:lookup_app/ui/card_signup.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40),
          CardSignUp(),
        ],
      ),
    ));
  }
}
