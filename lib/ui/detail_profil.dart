import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/resources/firestore_method.dart';
import 'package:lookup_app/screen/ThePage.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/utils/utils.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

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
      drawer: Sidebar(),
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
  Uint8List? _file;
  bool isLoading = true;
  late String username = "";
  late String uid = "";
  late String photoURL;
  late String email = "";

  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initUserData();
  }

  Future<void> initUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await getUser();
    } else {
      setState(() {
        username = "username";
        photoURL =
            "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        isLoading = false;
      });
    }
  }

  Future<void> getUser() async {
    final userData = await AuthMethods().getUserData("username");
    final userPhotoURL = await AuthMethods().getUserData("photoUrl");
    final userUid = await AuthMethods().getUserData("uid");
    final userEmail = await AuthMethods().getUserData("email");

    setState(() {
      email = userEmail ?? "email@gmail.com";
      uid = userUid ?? "uid";
      username = userData ?? "username";
      photoURL = userPhotoURL ??
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
      isLoading = false;
    });
    _usernameController.text = username;
    photoURL = userPhotoURL!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(children: [
            _file != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(_file!),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        photoURL.isNotEmpty ? NetworkImage(photoURL) : null,
                  ),
            Positioned(
              bottom: -10,
              left: 80,
              child: IconButton(
                onPressed: _selectImage,
                icon: const Icon(Icons.add_a_photo),
              ),
            )
          ]),
          const SizedBox(height: 16),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
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

  Future<void> _selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _file = im;
      print(_file);
    });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  Future<void> _saveProfile() async {
    isLoading = true;
    String res;
    try {
      res = await FireStoreMethods().updateUser(
          file: _file,
          uid: uid,
          username: _usernameController.text,
          photoUrl: photoURL,
          email: email);

      showSnackBar(context, res);
      isLoading = false;
    } catch (e) {
      showSnackBar(context, e.toString());
      isLoading = false;
    }

    // Save the profile data or make API calls here
  }
}
