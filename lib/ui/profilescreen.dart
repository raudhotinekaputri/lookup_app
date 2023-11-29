import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User? _user; // Firebase User object
  late String _username = ''; // Username

  @override
  void initState(){
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    // Get current authenticated user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        _user = currentUser;
      });

      // Get username from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      setState(() {
        _username = userDoc['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAfKzHBWV9eMbpQ3qNmYn5dIZDtFCQtuKvUw&usqp=CAU"),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _username,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'syifahadju@mail.com',
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
            buildMenu('Edit Profil', Icons.account_circle),
            SizedBox(height: 20),
            buildMenu('Bantuan', Icons.help_outline),
            SizedBox(height: 20),
            buildMenu('Keluar', Icons.exit_to_app),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(String title, IconData icon) {
    return Container(
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
    );
  }
}
