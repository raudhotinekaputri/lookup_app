import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookup_app/resources/storage_methods.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/navbottom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>?> items = [];
  List<Map<String, dynamic>?> filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> searchItems(String query) async {
    try {
      String lowercaseQuery = query.toLowerCase();

      QuerySnapshot<Map<String, dynamic>?> searchResults = await _firestore
          .collection('posts')
          .where('deskripsi', arrayContains: lowercaseQuery)
          .get();

      List<Map<String, dynamic>?> results = searchResults.docs
          .map((DocumentSnapshot<Map<String, dynamic>?> document) =>
              document.data())
          .toList();

      setState(() {
        items = results;
        filterItems(query);
      });
    } catch (e) {
      print("Error searching items: $e");
    }
  }

  void filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = items;
      } else {
        filteredItems = items
            .where((item) =>
                item?['judul']?.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: SafeArea(
        child: Column(
          children: [
            // Add TopBanner here
            TopBanner(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 336,
                height: 56,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 24),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) {
                          searchItems(query);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari dan temukan barang Anda',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: Future.delayed(Duration(seconds: 3)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CardContainer(
                            jenis: filteredItems[index]?['jenis']?.toString() ??
                                '',
                            judul: filteredItems[index]?['judul']?.toString() ??
                                '',
                            akun:
                                filteredItems[index]?['username']?.toString() ??
                                    '',
                            status:
                                filteredItems[index]?['status']?.toString() ??
                                    '',
                            gambar:
                                filteredItems[index]?['postUrl']?.toString() ??
                                    '',
                            uid: filteredItems[index]?['uid']?.toString() ?? '',
                            deskripsi: filteredItems[index]?['deskripsi']
                                    ?.toString() ??
                                '',
                            postId:
                                filteredItems[index]?['postId']?.toString() ??
                                    '',
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }

  Widget TopBanner() {
    return Column(
      children: [
        Container(
          width: 393,
          height: 123,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 126,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/search.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 25,
                child: Container(
                  width: 390,
                  height: 126,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LookUp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'Cari dan temukan barang Anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
