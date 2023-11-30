import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookup_app/models/user.dart';
import 'package:lookup_app/providers/user_provider.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/resources/firestore_method.dart';
import 'package:lookup_app/screen/ThePage.dart';
import 'package:lookup_app/utils/utils.dart';
import 'package:lookup_app/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class UpdatePostScreen extends StatefulWidget {
  String jenis;
  String judul;
  String postUrl;
  String deskripsi;
  String uid;
  String postId;
  String status;
  UpdatePostScreen(
      {Key? key,
      required this.jenis,
      required this.judul,
      required this.postUrl,
      required this.deskripsi,
      required this.uid,
      required this.postId,
      required this.status})
      : super(key: key);

  @override
  _UpdatePostScreenState createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _deskripsiPostController =
      TextEditingController();

  final TextEditingController _judulPostController = TextEditingController();

  late String _jenis;
  late String _status;
  late String uid;
  late String username;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _file = im;
      print(_file);
    });
  }

  void postImage() async {
    setState(() {
      isLoading = true;
    });

    try {
      username = (await AuthMethods().getUserData("username"))!;
      print('Username: $username');
      uid = (await AuthMethods().getUserData("uid"))!;
      print('uid: $uid');
    } catch (error) {
      // Handle errors
      print('Error in someFunction: $error');
    }
    try {
      String res = await FireStoreMethods().updatePost(
        file: _file,
        postUrl: widget.postUrl,
        uid: uid,
        username: username,
        judul: _judulPostController.text,
        status: _status,
        deskripsi: _deskripsiPostController.text,
        jenis: _jenis,
        postId: widget.postId,
      );

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(
            context,
            'Posted!',
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ThePage(),
            ),
            (route) => false,
          );
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _deskripsiPostController.dispose();
    _judulPostController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _deskripsiPostController.text = widget.deskripsi;
    _judulPostController.text = widget.judul;
    _jenis = widget.jenis;
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: clearImage,
          ),
          title: const Text(
            'Posting',
          ),
          centerTitle: false,
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFieldInput(
                    textEditingController: _judulPostController,
                    hintText: 'Judul',
                    textInputType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFieldInput(
                    textEditingController: _deskripsiPostController,
                    hintText: 'Deskripsi',
                    textInputType: TextInputType.text,
                  ),
                ),
                Stack(
                  children: [
                    _file != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_file!),
                            backgroundColor: Colors.red,
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(widget.postUrl),
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
              ],
            ),
            const Divider(),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Jenis Postingan?",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Divider(),
                  RadioListTile(
                    title: const Text("Kehilangan"),
                    value: "Kehilangan",
                    groupValue: _jenis,
                    onChanged: (value) {
                      setState(() {
                        _jenis =
                            value.toString().isEmpty ? "" : value.toString();
                        print(_jenis);
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Ditemukan"),
                    value: "Ditemukan",
                    groupValue: _jenis,
                    onChanged: (value) {
                      setState(() {
                        _jenis =
                            value.toString().isEmpty ? "" : value.toString();
                        print(_jenis);
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            InkWell(
              onTap: postImage,
              child: Container(
                child: !isLoading
                    ? const Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.blue,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
