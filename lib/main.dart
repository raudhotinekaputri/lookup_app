import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/screens/signup_screen.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCqwd5L11mayRTMNVxj36OqTVnvu970efE",
      appId: "1:4338278854:web:061fcc0ff1756d424752c7",
      messagingSenderId: "4338278854",
      projectId: "lookup-app-3271c",
      storageBucket: "lookup-app-3271c.appspot.com",
    ));
  }
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: const NavTop (),
    );
  }
}
