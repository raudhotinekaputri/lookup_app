import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/responsive/mobile_screen_layout.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Future<Object> Function()? onPressed; // Ubah tipe fungsi onPressed
  const SquareTile({
    Key? key, // Tambahkan Key? key di sini
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result =
            await onPressed!(); // Tambah await dan panggil onPressed sebagai fungsi
        if (result is UserCredential) {
          // Jika berhasil login dengan Google, arahkan ke halaman MobileScreenLayout
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MobileScreenLayout(),
          ));
        } else {
          // Tambahkan penanganan kesalahan jika login gagal
          // Contoh:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to sign in with Google')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
