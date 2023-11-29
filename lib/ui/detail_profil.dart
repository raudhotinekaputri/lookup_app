import 'package:flutter/material.dart';
import 'package:lookup_app/screen/ThePage.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';
import 'package:lookup_app/ui/homecard.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  get uid => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThePage()),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ubah Profil'),
            Text('LookUp!', style: TextStyle(fontSize: 20)),
          ],
        ),
        actions: [
          // Add other actions if needed
        ],
      ),
      drawer: Sidebar(
        uid: null,
      ),
      bottomNavigationBar: const NavBottom(),
      body: Container(
        color: const Color(0xFF212121),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ProfileEditForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({Key? key}) : super(key: key);

  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedImagePath = ''; // Placeholder for selected image path

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _selectImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _selectedImagePath.isNotEmpty
                  ? NetworkImage(_selectedImagePath)
                  : null,
              child: _selectedImagePath.isEmpty
                  ? const Icon(Icons.add_a_photo, size: 40, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Konfirmasi Password'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF586CA6),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectImage() {
    // Implement image selection logic here
    // For example, you can use the image_picker package
  }

  void _saveProfile() {
    // Implement profile saving logic here
    String name = _nameController.text;
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Validate the form
    if (name.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      // Show an error message or handle validation accordingly
      return;
    }

    if (password != confirmPassword) {
      // Passwords do not match, show an error message
      return;
    }

    // Save the profile data or make API calls here
  }
}
