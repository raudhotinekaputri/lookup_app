import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          const SizedBox(height: 96),
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

class CardContainer extends StatelessWidget {
  final String jenis;
  final String judul;
  final String akun;
  final String status;
  final String gambar;
  final String uid;
  final String deskripsi;

  CardContainer({
    Key? key,
    required this.jenis,
    required this.judul,
    required this.akun,
    required this.status,
    required this.gambar,
    required this.uid,
    required this.deskripsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 400,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Text(
                        jenis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Center(
                      child: Image.network(
                        gambar, // Sesuaikan lebar gambar
                        height: 100, // Sesuaikan tinggi gambar
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      akun,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Lakukan sesuatu saat tombol ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeMorePage(
                                  jenis: jenis,
                                  judul: judul,
                                  status: status,
                                  deskripsi: deskripsi,
                                  photoUrl: gambar,
                                  uid: uid)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(
                            0xFF8C92B6), // Ganti warna latar belakang sesuai keinginan Anda
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
      ),
    );
  }
}
