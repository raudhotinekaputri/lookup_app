import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lookup_app/screen/ThePage.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/ui/login_page.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/profile.dart';
import 'package:lookup_app/ui/sidebar.dart';
import 'package:lookup_app/ui/signup_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    //bisa diganti beberapa detik sesuai keinginan
    var durasiSplash = const Duration(seconds: 5);
    return Timer(durasiSplash, () {
      //pindah ke halaman home
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const CreatePost();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:
            Image.asset("assets/look-up-high-resolution-logo.png", width: 200),
      ),
    );
  }
}
