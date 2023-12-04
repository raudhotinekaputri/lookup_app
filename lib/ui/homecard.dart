import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/see_more.dart';
import 'package:lookup_app/ui/sidebar.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CardContainer(
                        jenis: snapshot.data!.docs[index]
                            .data()['jenis']
                            .toString(),
                        judul: snapshot.data!.docs[index]
                            .data()['judul']
                            .toString(),
                        akun: snapshot.data!.docs[index]
                            .data()['username']
                            .toString(),
                        status: snapshot.data!.docs[index]
                            .data()['status']
                            .toString(),
                        gambar: snapshot.data!.docs[index]
                            .data()['postUrl']
                            .toString(),
                        uid:
                            snapshot.data!.docs[index].data()['uid'].toString(),
                        deskripsi: snapshot.data!.docs[index]
                            .data()['deskripsi']
                            .toString(),
                        postId: snapshot.data!.docs[index]
                            .data()['postId']
                            .toString(),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CreatePost()), // Ganti dengan halaman membuat post Anda
          );
        },
        tooltip: 'Create Post',
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.black),
      ),
      // body: SafeArea(
      //   child: Column(children: [
      //     SizedBox(height: 96),
      //     Padding(padding:EdgeInsets.symmetric(vertical: 10), child:CardContainer() ,),
      //     SizedBox(height: 16.0),
      //       CardContainer(),
      //   ],)
      // ),
    );
  }
}

class CardContainer extends StatefulWidget {
  final String jenis;
  final String judul;
  final String akun;
  final String status;
  final String gambar;
  final String uid;
  final String deskripsi;
  final String postId;

  CardContainer({
    Key? key,
    required this.jenis,
    required this.judul,
    required this.akun,
    required this.status,
    required this.gambar,
    required this.uid,
    required this.deskripsi,
    required this.postId,
  }) : super(key: key);

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  late String username = "";

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
      });
    }
  }

  Future<void> getUser() async {
    final userData =
        await AuthMethods().getUserDataById("username", widget.uid);

    setState(() {
      username = userData ?? "username";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                widget.gambar,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.judul,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.account_circle, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.info, size: 16, color: Colors.red),
                      SizedBox(width: 4),
                      Text(
                        widget.status,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    widget.deskripsi,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeMorePage(
                            jenis: widget.jenis,
                            judul: widget.judul,
                            status: widget.status,
                            deskripsi: widget.deskripsi,
                            photoUrl: widget.gambar,
                            uid: widget.uid,
                            postId: widget.postId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF8C92B6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text('Lihat'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
