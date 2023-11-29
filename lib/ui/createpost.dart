import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookup_app/providers/user_provider.dart';
import 'package:lookup_app/resources/firestore_method.dart';
import 'package:lookup_app/utils/utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CreatePosting());
}

class CreatePosting extends StatelessWidget {
  const CreatePosting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: SafeArea(child: ListView(children: const [CreatePost()])),
      ),
    );
  }
}

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String _status = 'Kehilangan';
  String _jenis = '';
  Uint8List? _file;
  bool isLoading = false;

  final _judulPostTextboxController = TextEditingController();
  final _deskripsiPostController = TextEditingController();

  Future<void> _getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _file = File(image.path).readAsBytesSync();
      });
    }
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List? file = await pickImage(ImageSource.camera);
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                }
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.gallery);
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                }
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (_file != null) {
        // Print data before processing
        print('UID: $uid');
        print('Username: $username');
        print('Judul: ${_judulPostTextboxController.text}');
        print('Status: $_status');
        print('Deskripsi: ${_deskripsiPostController.text}');
        print('Jenis: $_jenis');

        // Continue with the upload to storage and db
        String res = await FireStoreMethods().uploadPost(
          file: _file!,
          uid: uid,
          username: username,
          judul: _judulPostTextboxController.text,
          status: _status,
          deskripsi: _deskripsiPostController.text,
          jenis: _jenis,
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
          }
          clearImage();
        } else {
          if (context.mounted) {
            showSnackBar(context, res);
          }
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Please select an image.');
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
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create & Posting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _judulPostTextboxController,
                              decoration: const InputDecoration(
                                hintText: 'Judul',
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                _getImageFromGallery();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    isLoading
                                        ? const LinearProgressIndicator()
                                        : const Padding(
                                            padding: EdgeInsets.only(top: 0.0)),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        if (_file != null)
                                          SizedBox(
                                            height: 45.0,
                                            width: 45.0,
                                            child: AspectRatio(
                                              aspectRatio: 487 / 451,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    alignment: FractionalOffset
                                                        .topCenter,
                                                    image: MemoryImage(_file!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: const [
                                        Text(
                                          'Pilih Gambar Dari Galeri',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 60),
                                        Icon(
                                          Icons.photo,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Kehilangan',
                                      groupValue: _status,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _status = value!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'Kehilangan',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Radio<String>(
                                      value: 'Ditemukan',
                                      groupValue: _status,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _status = value!;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'Ditemukan',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 20),
                            Container(
                              height: 376,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: _deskripsiPostController,
                                style: const TextStyle(color: Colors.black),
                                maxLines: 10,
                                decoration: const InputDecoration(
                                  hintText: 'Deskripsi',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFA3A3A3),
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FloatingActionButton(
                              onPressed: () => postImage(
                                userProvider.getUser?.uid ?? '',
                                userProvider.getUser?.username ?? '',
                              ),
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
