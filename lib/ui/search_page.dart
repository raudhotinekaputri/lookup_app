import 'package:flutter/material.dart';
import 'package:lookup_app/resources/storage_methods.dart';
import 'package:lookup_app/ui/navbottom.dart';

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
                    image: AssetImage("search.png"),
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

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> items = [];
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> searchItems(String query) async {
    try {
      List<String> searchResults = await StorageMethods().searchItems(query);

      setState(() {
        items = searchResults;
        filterItems(query);
      });
    } catch (e) {
      print("Error searching items: $e");
    }
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF212121),
        body: SafeArea(
          child: Column(
            children: [
              TopBanner(),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 336,
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                          onChanged: (query) {
                            filterItems(query);
                          },
                          onSubmitted: (query) {
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
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredItems[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const NavBottom(),
      ),
    );
  }
}
