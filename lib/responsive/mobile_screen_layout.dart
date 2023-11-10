import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/screens/login_screen.dart'; // Import file LoginScreen.dart

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                await AuthMethods().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: Colors.blue,
                ),
                child: const Text(
                  'Logout', // Ubah teks menjadi 'Logout' untuk mencerminkan fungsi tombol
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
