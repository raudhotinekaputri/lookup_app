import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/providers/user_provider.dart';
import 'package:lookup_app/responsive/mobile_screen_layout.dart';
import 'package:lookup_app/responsive/responsive_layout.dart';
import 'package:lookup_app/responsive/web_screen_layout.dart';
import 'package:lookup_app/screen/ThePage.dart';
import 'package:lookup_app/ui/comment.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/ui/comment.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/ui/editpost.dart';
import 'package:lookup_app/ui/see_more.dart';
import 'package:lookup_app/ui/signup_page.dart';
import 'package:lookup_app/ui/splash_screen.dart';
import 'package:lookup_app/utils/colors.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCqwd5L11mayRTMNVxj36OqTVnvu970efE",
          authDomain: "lookup-app-3271c.firebaseapp.com",
          databaseURL:
              "https://lookup-app-3271c-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "lookup-app-3271c",
          storageBucket: "lookup-app-3271c.appspot.com",
          messagingSenderId: "4338278854",
          appId: "1:4338278854:web:061fcc0ff1756d424752c7",
          measurementId: "G-6Q2W2968YJ"),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ThePage();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const SplashScreenPage();
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpCLient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
