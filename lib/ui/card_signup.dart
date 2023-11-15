import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/screens/signup_screen.dart';
import 'package:lookup_app/ui/comp/google_logo.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/login_page.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/utils/colors.dart';
import 'package:lookup_app/utils/utils.dart';
import 'package:lookup_app/widgets/square_tile.dart';
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmPasswordController.dispose();
  }
  bool _obscurePassword = true;
  bool _isPass = true;

  void _navigateToLoginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    String res = "Error";
    if (_passwordController.text == _confirmPasswordController.text) {
      // signup user using our authmethodds
      res = await AuthMethods().signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          file: _image!);
    } else {
      res = "Confirmed Password is different!";
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
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
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Nama pengguna',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Alamat email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              // ...
TextFieldInput(
  textEditingController: _passwordController,
  hintText: 'Kata sandi',
  textInputType: TextInputType.text,
  isPass: _isPass,
  suffixIcon: IconButton(
    icon: Icon(
      _isPass
          ? Icons.visibility_off
          : Icons.visibility,
      color: Colors.black,
    ),
    onPressed: () {
      setState(() {
        _isPass = !_isPass;
      });
    },
  ),
),
const SizedBox(height: 24),
TextFieldInput(
  textEditingController: _confirmPasswordController,
  hintText: 'Konfirmasi Kata Sandi',
  textInputType: TextInputType.text,
  isPass: _isPass,
  suffixIcon: IconButton(
    icon: Icon(
      _isPass
          ? Icons.visibility_off
          : Icons.visibility,
      color: Colors.black,
    ),
    onPressed: () {
      setState(() {
        _isPass = !_isPass;
      });
    },
  ),
),
// ...

              const SizedBox(height: 24),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
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
