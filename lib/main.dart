import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/providers/user_provider.dart';
import 'package:lookup_app/ui/comment.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/responsive/mobile_screen_layout.dart';
import 'package:lookup_app/responsive/responsive_layout.dart';
import 'package:lookup_app/ui/profilescreen.dart';
import 'package:lookup_app/responsive/web_screen_layout.dart';
import 'package:lookup_app/screens/login_screen.dart';
import 'package:lookup_app/ui/splash_screen.dart';
import 'package:lookup_app/utils/colors.dart';
import 'package:lookup_app/ui/homecard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCZ-xrXqD5D19Snauto-Fx_nLD7PLrBXGM",
          appId: "1:585119731880:web:eca6e4b3c42a755cee329d",
          messagingSenderId: "585119731880",
          projectId: "instagram-clone-4cea4",
          storageBucket: 'instagram-clone-4cea4.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      // mobileScreenLayout: MobileScreenLayout(),
      //  webScreenLayout: WebScreenLayout(),
      // ),
      home: SplashScreenPage(),
    );
  }
}