import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/resources/firestore_method.dart';
import 'package:lookup_app/screen/ThePage.dart';
import 'package:lookup_app/ui/comment.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/ui/editpost.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';
import 'package:lookup_app/ui/updatepost_niru.dart';
import 'package:lookup_app/utils/utils.dart';

class SeeMorePage extends StatefulWidget {
  String jenis;
  String judul;
  String status;
  String photoUrl;
  String deskripsi;
  String uid;
  String postId;

  SeeMorePage(
      {Key? key,
      required this.jenis,
      required this.judul,
      required this.status,
      required this.photoUrl,
      required this.deskripsi,
      required this.uid,
      required this.postId})
      : super(key: key);

  @override
  State<SeeMorePage> createState() => _SeeMorePageState();
}

class _SeeMorePageState extends State<SeeMorePage> {
  late Widget titleSection;
  late Widget imageSection;
  late Widget profileSection;
  late String username = "";
  late String senderUsername = "";
  late String photoURL;
  late String senderPhotoUrl = "";
  late Widget textSection;
  late bool isthesender = false;
  late String dropdownValue;

  @override
  Future<void> getUser() async {
    final userName = await AuthMethods().getUserData("username");
    final userPhotoURL = await AuthMethods().getUserData("photoUrl");
    final userID = await AuthMethods().getUserData("uid");
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    senderPhotoUrl =
        "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
    senderUsername = "sender";
    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where("uid", isEqualTo: widget.uid).get();

      if (querySnapshot.size > 0) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
        final senderUsernameData = documentSnapshot["username"];
        final senderPhotoUrlData = documentSnapshot["photoUrl"];
        setState(() {
          this.senderUsername = senderUsernameData ?? "username";
          this.senderPhotoUrl = senderPhotoUrlData ??
              "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        });

        print("Sender Username: $senderUsername");
        print("Sender Photo URL: $senderPhotoUrl");
      } else {
        print("No user found with the provided UID");
      }
      if (widget.uid == userID) {
        isthesender = true;
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    dropdownValue = widget.status == "belum" || widget.status == "Belum Selesai"
        ? "Belum Selesai"
        : "Sudah Selesai";
  }

  @override
  Widget build(BuildContext context) {
    // Call getUser directly in the build method

    titleSection = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  widget.jenis,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isthesender
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdatePostScreen(
                              postId: widget.postId,
                              judul: widget.judul,
                              deskripsi: widget.deskripsi,
                              jenis: widget.jenis,
                              postUrl: widget.photoUrl,
                              uid: widget.uid,
                              status: widget.status,
                            ),
                          ),
                        );
                      },
                      child: const Hero(
                        tag: 'uniqueTagForEditButton',
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                margin: const EdgeInsets.only(top: 4),
              ),
              isthesender
                  ? GestureDetector(
                      onTap: () async {
                        String res;
                        try {
                          res = await FireStoreMethods()
                              .deletePost(widget.postId);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ThePage(),
                            ),
                          );
                          showSnackBar(context, "Hapus Post Berhasil");
                        } catch (e) {
                          showSnackBar(context, "Hapus Post Gagal");
                        }
                      },
                      child: const Hero(
                        tag: 'uniqueTagForEditButton',
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );

    imageSection = Container(
      padding: const EdgeInsets.all(16),
      child: Image.network(
        widget.photoUrl,
        width: 600,
        height: 240,
        fit: BoxFit.cover,
      ),
    );

    profileSection = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  senderPhotoUrl,
                ),
                radius: 15,
              ),
              const SizedBox(width: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    senderUsername,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          isthesender
              ? DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) async {
                    setState(() async {
                      // Perbarui nilai dropdown saat terjadi perubahan
                      try {
                        await FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.postId)
                            .update({'status': dropdownValue});

                        showSnackBar(context, "Berhasil Edit");
                        setState(() {
                          dropdownValue = newValue!;
                        });

                        print(dropdownValue);
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      print(dropdownValue);
                    });
                  },
                  items: <String>['Sudah Selesai', 'Belum Selesai']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          color: value == 'Sudah Selesai'
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                    );
                  }).toList(),
                )
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );

    textSection = Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        widget.deskripsi,
        softWrap: true,
        style: const TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
      floatingActionButton: commentButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: NavTop(),
      drawer: const Sidebar(uid: null),
      bottomNavigationBar: const NavBottom(),
      body: Container(
        color: const Color(0xFF212121),
        child: SafeArea(
          child: Column(
            children: [titleSection, imageSection, profileSection, textSection],
          ),
        ),
      ),
    );
  }

  Widget commentButton(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          onPressed: () {
            // Implement your onPressed logic here
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Comment(
                        pengirim: '',
                      )),
            );
          },
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF292929),
          shape: const CircleBorder(),
          child: const Icon(Icons.comment),
        ),
      ),
    );
  }
}
