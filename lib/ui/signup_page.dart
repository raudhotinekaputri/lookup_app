import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Card and TextField Sample')),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE5E5E5),
          ),
          child: const SignUpPage(),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black, // Ganti dengan warna yang diinginkan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins', // Tambahkan fontFamily
                  ),
                ),
                subtitle: const Text('Buat akun untuk melanjutkan'),
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
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'), // Tambahkan fontFamily
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
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'), // Tambahkan fontFamily
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
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'), // Tambahkan fontFamily
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
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins'), // Tambahkan fontFamily
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  // Add logic for sign up
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)), // Mengubah radius menjadi 30
                    ),
                    color: Color(0xFF586CA6),
                  ),
                  child: !_isLoading
                      ? const Text('Sign Up', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')) // Tambahkan fontFamily
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
                    onTap: () {
                      // Add logic to navigate to login screen
                    },
                    child: const Text(
                      ' Login.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontFamily: 'Poppins', // Tambahkan fontFamily
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
