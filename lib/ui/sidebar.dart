import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sidebar extends StatelessWidget {
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // User? user = FirebaseAuth.instance.currentUser;
  // final uid = FirebaseAuth.instance.currentUser!.uid;

  // final userDocRef = firestore.collection('users').doc(uid);
  
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
            // UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(
            //     color:  Color(0xFF586CA6),
            //   ),
            //   accountName: Text(
                
            //     user.displayName ?? '',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   accountEmail: null,
            //   currentAccountPicture: CircleAvatar(
            //     backgroundImage: NetworkImage(
            //       user.photoURL ?? '',
            //     ),
            //   ),
            //   onDetailsPressed: () {
            //     //lorem
            //   },
            // ),
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF586CA6),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text('Profil', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.article, color: Colors.white),
              title: Text('My Post', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
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
            // Tambahkan item-menu lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lookup_app/resources/auth_method.dart';
// import 'package:lookup_app/ui/login_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Sidebar extends StatefulWidget {
//   const Sidebar({Key? key}) : super(key: key);

//   @override
//   State<Sidebar>createState() => _SidebarState();

// }

// class _SidebarState extends State<Sidebar> {
//   final ref = FirebaseDatabase.instance.ref('users');
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
