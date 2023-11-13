import 'package:flutter/material.dart';
import 'package:lookup_app/ui/card_signup.dart';
import 'package:lookup_app/ui/signup_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CardSignUp(),
    );
  }
}
