import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/screens/signup_screen.dart';
import 'package:lookup_app/ui/comp/google_logo.dart';
import 'package:lookup_app/ui/login_page.dart';
import 'package:lookup_app/utils/colors.dart';
import 'package:lookup_app/utils/utils.dart';
import 'package:lookup_app/widgets/text_field_input.dart';

class CardSignUp extends StatefulWidget {
  const CardSignUp({Key? key}) : super(key: key);

  @override
  _CardSignUpState createState() => _CardSignUpState();
}

class _CardSignUpState extends State<CardSignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _navigateToLoginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _signUp() {
    // Add logic for sign up
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        color: cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  // Tambahkan SizedBox untuk memberi jarak
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text('Buat akun untuk melanjutkan'),
                      SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GoogleLogo(),
                ],
              ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nama pengguna',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                controller: _usernameController,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Alamat email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                ),
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                controller: _emailController,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Kata sandi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                controller: _passwordController,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Kata Sandi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: _signUp,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    color: const Color(0xFF586CA6),
                  ),
                  child: !_isLoading
                      ? const Text('Sign Up', style: TextStyle(color: Colors.white, fontFamily: 'Poppins'))
                      : const CircularProgressIndicator(
                          color: Colors.black,
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  GestureDetector(
                    onTap: _navigateToLoginPage,
                    child: const Text(
                      ' Login.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
