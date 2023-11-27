import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/ui/login_page.dart';
import 'package:lookup_app/utils/utils.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key, required uid}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late User? _user;
  late String _photoURL;
  late String _username;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _loadUserData(_user!.uid);
    }
  }

  void _loadUserData(String uid) async {
    try {
      var snap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (snap.exists) {
        setState(() {
         Map<String, dynamic> data = snap.data()!;
          _photoURL = data['photoURL'] ?? ''; // Handling null value
          _username = data['username'] ?? ''; // Handling null value
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
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
              child: _user != null
                  ? Row(
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
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(_photoURL),
                                  radius: 25,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _username,
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
                    )
                  : SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0), // Atur jarak ke kiri
              child: ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text('Home', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0), // Atur jarak ke kiri
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text('Profil', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0), // Atur jarak ke kiri
              child: ListTile(
                leading: Icon(Icons.article, color: Colors.white),
                title: Text('My Post', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0), // Atur jarak ke kiri
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



