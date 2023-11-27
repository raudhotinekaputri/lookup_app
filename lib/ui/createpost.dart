import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const CreatePosting());
}

class CreatePosting extends StatelessWidget {
  const CreatePosting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: SafeArea(child: ListView(children: [CreatePost()])),
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
  String _status = 'Kehilangan'; // Nilai default untuk Status

  final _judulPostTextboxController = TextEditingController();
  final _deskripsiPostController = TextEditingController();

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
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
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
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _file!,
        uid,
        username,
        _judulPostTextboxController.text,
        _status,
        _deskripsiPostController.text,
        _jenis,
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
    _judulPostTextboxController.dispose();
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
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
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
      // Check if _file is not null before proceeding
      if (_file != null) {
        // upload to storage and db
        String res = await FireStoreMethods().uploadPost(
          _file!,
          uid,
          username,
          _judulPostTextboxController.text,
          _status,
          _deskripsiPostController.text,
          _jenis,
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
        // Handle the case where _file is null
        if (context.mounted) {
          showSnackBar(context, 'Please select an image before posting.');
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 393,
            height: 852,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF292929)),
            child: Stack(children: [
              Positioned(
                left: 40, // Sesuaikan posisi tombol kembali di sini
                top:
                    85, // Sesuaikan posisi tombol kembali di sini, agar sejajar dengan teks 'Create & Posting'
                child: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Colors.white), // Menggunakan ikon panah ke kiri
                  onPressed: () {
                    // Tambahkan logika untuk kembali ke halaman sebelumnya di sini
                    // Misalnya, Anda bisa menggunakan Navigator.pop(context) untuk kembali
                  },
                ),
              ),
              Positioned(
                left: 59,
                top: 95,
                child: SizedBox(
                  width: 285,
                  height: 33,
                  child: Text(
                    'Create & Posting',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),

              // Positioned(
              // left: 558,
              // top: 50,
              //child: Container(
              // width: 683,
              // height: 455,
              //decoration: BoxDecoration(
              //image: DecorationImage(
              //image:
              //  NetworkImage("https://via.placeholder.com/683x455"),
              //fit: BoxFit.contain,
              // ),
              // ),
              // ),
              //),
              //Positioned(
              //left: 302.66,
              //top: 769,
              //child: Transform(
              //transform: Matrix4.identity()
              //..translate(0.0, 0.0)
              //..rotateZ(0.16),
              //child: Container(
              //width: 43,
              //height: 42.97,
              //decoration: ShapeDecoration(
              //color: Colors.white,
              //shape: OvalBorder(),
              //),
              //),
              //),
              //),
              Stack(
                children: [
                  Positioned(
                    left: 290,
                    top: 800,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Tambahkan logika untuk tombol submit di sini
                        // Misalnya, Anda bisa menambahkan panggilan fungsi untuk menangani proses pengiriman post
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        color: Colors
                            .green, // Sesuaikan warna ikon sesuai keinginan
                      ),
                    ),
                  ),
                  Positioned(
                    left: -4,
                    top: -1,
                    child: Container(
                      width: 411,
                      height: 65,
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 32,
                        right: 41,
                        bottom: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 47,
                    top: 99,
                    child: Container(
                      width: 24,
                      height: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Stack(children: []),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 153,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 294,
                                  height: 56,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _judulPostTextboxController,
                                    style: const TextStyle(
                                        color: Colors
                                            .black), // Teks input pengguna
                                    // TextFormField untuk Judul
                                    decoration: InputDecoration(
                                      hintText: 'Judul',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFA3A3A3),
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: 294,
                                  height: 56,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      _getImageFromGallery(); // Panggil fungsi untuk mengambil gambar dari galeri
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pilih Gambar Dari Galeri',
                                          style: TextStyle(
                                            color: Color(0xFFA3A3A3),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width:
                                                    60), // Jarak antara ikon dan teks
                                            Icon(
                                              Icons.photo,
                                              color: Color(0xFFA3A3A3),
                                              size: 24,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                    width: 294,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF5F5F5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    color: Color(0xFFA3A3A3),
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                                                visualDensity: VisualDensity(
                                                    horizontal: -4,
                                                    vertical:
                                                        0), // Mengatur posisi lebih ke kiri
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                activeColor: Colors
                                                    .black, // Mengatur warna lingkaran radio button
                                              ),
                                              Text(
                                                'Kehilangan',
                                                style: TextStyle(
                                                  color: Colors
                                                      .black, // Ubah warna teks menjadi hitam
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
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
                                                visualDensity: VisualDensity(
                                                    horizontal: 4,
                                                    vertical:
                                                        0), // Mengatur posisi lebih ke kiri
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                activeColor: Colors
                                                    .black, // Mengatur warna lingkaran radio button
                                              ),
                                              Text(
                                                'Ditemukan',
                                                style: TextStyle(
                                                  color: Colors
                                                      .black, // Ubah warna teks menjadi hitam
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ])),
                                const SizedBox(height: 20),
                                Container(
                                  width: 294,
                                  height: 376,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _deskripsiPostController,
                                    style: const TextStyle(
                                        color: Colors
                                            .black), // Teks input pengguna
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        hintText: 'Deskripsi',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFA3A3A3),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ])),
      ],
    );
  }
}
