import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24, // Ubah sesuai kebutuhan
      height: 24, // Ubah sesuai kebutuhan
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, // Warna latar belakang lingkaran
      ),
      child: Center(
        child: Image.asset('google.png'), // Ganti dengan path gambar Anda
      ),
    );
  }
}
