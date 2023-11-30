import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/ui/detail_profil.dart';
import 'package:lookup_app/ui/login_page.dart';

class Profile extends StatelessWidget {
  final String uid;

  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF212121),
      ),
      home: Scaffold(
        body: ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String photoURL;
  late String email;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initUserData();
  }

  Future<void> initUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await getUser();
    } else {
      setState(() {
        username = "username";
        email = "email@g.com";
        photoURL =
            "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        isLoading = false;
      });
    }
  }

  Future<void> getUser() async {
    final userData = await AuthMethods().getUserData("username");
    final userPhotoURL = await AuthMethods().getUserData("photoUrl");
    final userEmail = await AuthMethods().getUserData("email");

    setState(() {
      email = userEmail ?? "email@g.com";
      username = userData ?? "username";
      photoURL = userPhotoURL ??
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
      isLoading = false;
    });

    print(username);
    print(photoURL);
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 330,
                    height: 224,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 60,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20),
                          Container(
                            width: 133,
                            height: 133,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(photoURL),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            username,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Color(0xFFA3A3A3),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  buildMenu(
                    'Edit Profil',
                    Icons.account_circle,
                    () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const ProfilPage(),
                      ),
                      (route) => false,
                    ),
                  ),
                  SizedBox(height: 20),
                  // buildMenu('Bantuan', Icons.help_outline, () => BantuanPage()),
                  SizedBox(height: 20),
                  buildMenu(
                    'Keluar',
                    Icons.exit_to_app,
                    () async {
                      await AuthMethods().signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildMenu(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 330,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
