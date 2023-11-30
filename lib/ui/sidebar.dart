import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/screen/MyPostPage.dart';
import 'package:lookup_app/ui/login_page.dart';
import 'package:lookup_app/utils/utils.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late String username;
  late String photoURL;
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
        photoURL =
            "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        isLoading = false;
      });
    }
  }

  Future<void> getUser() async {
    final userData = await AuthMethods().getUserData("username");
    final userPhotoURL = await AuthMethods().getUserData("photoUrl");

    setState(() {
      username = userData ?? "username";
      photoURL = userPhotoURL ??
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
      isLoading = false;
    });

    print(username);
    print(photoURL);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      child: Container(
        width: screenWidth * 0.5,
        color: Color(0xFF586CA6),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF586CA6),
              ),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(this.photoURL),
                                  radius: 25,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      this.username,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0), // Adjust left padding
              child: ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 55.0), // Adjust left padding
            //   child: ListTile(
            //     leading: Icon(Icons.person, color: Colors.white),
            //     title: Text('Profil', style: TextStyle(color: Colors.white)),
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0), // Adjust left padding
              child: ListTile(
                leading: Icon(Icons.article, color: Colors.white),
                title: Text('My Post', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MyPostPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0), // Adjust left padding
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  await AuthMethods().signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
