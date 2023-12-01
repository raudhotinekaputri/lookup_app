import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/resources/firestore_method.dart';
import 'package:lookup_app/screen/ThePage.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';
import 'package:lookup_app/utils/utils.dart';
import 'package:lookup_app/widgets/text_field_input.dart';
import 'dart:typed_data' show Uint8List;

import 'package:get/state_manager.dart';
import 'package:lookup_app/models/user.dart';
import 'package:lookup_app/providers/user_provider.dart';

import 'package:provider/provider.dart';

//void main() {
// runApp(const EditPosting());
//}

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _deskripsiPostController =
      TextEditingController();
  final TextEditingController _judulPostController = TextEditingController();
  String _jenis = "Kehilangan";
  final String _status = "belum";
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
      if (_file != null) {
        String res = await FireStoreMethods().uploadPost(
          file: _file!,
          uid: uid,
          username: username,
          judul: _judulPostController.text,
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
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Please select an image.');
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavTop(),
        bottomNavigationBar: NavBottom(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            postImage();
            // Tambahkan logika untuk tombol submit di sini
            // Misalnya, Anda bisa menambahkan panggilan fungsi untuk menangani proses pengiriman post
          },
          backgroundColor: Colors.white,
          child: !isLoading
              ? Icon(
                  Icons.check,
                  color: Colors.green, // Sesuaikan warna ikon sesuai keinginan
                )
              : const CircularProgressIndicator(
                  color: Colors.blue,
                ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: 393,
                  height: 1200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFF292929)),
                  child: Stack(children: [
                    Positioned(
                      left: 40, // Sesuaikan posisi tombol kembali di sini
                      top:
                          85, // Sesuaikan posisi tombol kembali di sini, agar sejajar dengan teks 'Create & Posting'
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                            color:
                                Colors.white), // Menggunakan ikon panah ke kiri
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeCard()), // Ganti HomePage() dengan halaman yang sesuai
                          );
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
                          'Add Post',
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
                          top: 900,
                          child: FloatingActionButton(
                            onPressed: () {
                              postImage;
                              // Tambahkan logika untuk tombol submit di sini
                              // Misalnya, Anda bisa menambahkan panggilan fungsi untuk menangani proses pengiriman post
                            },
                            backgroundColor: Colors.white,
                            child: !isLoading
                                ? Icon(
                                    Icons.check,
                                    color: Colors
                                        .green, // Sesuaikan warna ikon sesuai keinginan
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.blue,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 294,
                                        height: 56,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFF5F5F5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _judulPostController,
                                          style: const TextStyle(
                                              color: Colors
                                                  .black), // Teks input pengguna
                                          // TextField untuk Judul
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
                                        child: Stack(
                                          children: [
                                            _file != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                    child: Image.memory(_file!))
                                                : const CircleAvatar(
                                                    radius: 64,
                                                    backgroundColor: Colors.red,
                                                  ),
                                            Positioned(
                                              bottom: -10,
                                              left: 80,
                                              child: IconButton(
                                                onPressed: selectImage,
                                                icon: const Icon(
                                                    Icons.add_a_photo),
                                              ),
                                            )
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 18),
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFF5F5F5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Status',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFA3A3A3),
                                                          fontSize: 16,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(),
                                                SizedBox(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Jenis Postingan?",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      const Divider(),
                                                      RadioListTile(
                                                        title: const Text(
                                                            "Kehilangan"),
                                                        value: "Kehilangan",
                                                        groupValue: _jenis,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _jenis = value
                                                                    .toString()
                                                                    .isEmpty
                                                                ? ""
                                                                : value
                                                                    .toString();
                                                            print(_jenis);
                                                          });
                                                        },
                                                      ),
                                                      RadioListTile(
                                                        title: const Text(
                                                            "Ditemukan"),
                                                        value: "Ditemukan",
                                                        groupValue: _jenis,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _jenis = value
                                                                    .toString()
                                                                    .isEmpty
                                                                ? ""
                                                                : value
                                                                    .toString();
                                                            print(_jenis);
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
          ),
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_status', _status));
  }
}
