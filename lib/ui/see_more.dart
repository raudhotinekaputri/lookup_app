import 'package:flutter/material.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/ui/createpost.dart';
import 'package:lookup_app/ui/editpost.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';

class SeeMorePage extends StatefulWidget {
  String jenis;

  String judul;

  String status;

  String photoUrl;

  String deskripsi;

  String uid;

  SeeMorePage(
      {Key? key,
      required this.jenis,
      required this.judul,
      required this.status,
      required this.photoUrl,
      required this.deskripsi,
      required this.uid})
      : super(key: key);

  @override
  State<SeeMorePage> createState() => _SeeMorePageState();
}

class _SeeMorePageState extends State<SeeMorePage> {
  late Widget titleSection;
  late Widget imageSection;
  late Widget profileSection;
  late String username;
  late String photoURL;
  late Widget textSection;
  bool isLoadinguser = true;
  Future<void> getUser() async {
    final userData = await AuthMethods().getUserData("username");
    final userPhotoURL = await AuthMethods().getUserData("photoUrl");

    setState(() {
      username = userData ?? "username";
      photoURL = userPhotoURL ??
          "https://images.unsplash.com/photo-1493612276216-ee3925520721?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
      isLoadinguser = false;
    });

    print(username);
    print(photoURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavTop(),
      drawer: Sidebar(
        uid: null,
      ),
      bottomNavigationBar: const NavBottom(),
      body: Container(
        color: const Color(0xFF212121), // Background color
        child: SafeArea(
          child: Column(
            children: [
              titleSection,
              imageSection,
              profileSection,
              textSection,
              commentButton,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
                    style: TextStyle(
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditPost(),
                    ),
                  );
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
              ),
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
                  widget.photoUrl,
                ),
                radius: 15,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoadinguser
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          username,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
            ],
          ),
          DropdownButton<String>(
            value: 'Sudah Selesai',
            onChanged: (String? newValue) {},
            items: <String>['Sudah Selesai', 'Belum Selesai']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        value == 'Sudah Selesai' ? Colors.blue : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
    textSection = Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        widget.deskripsi,
        softWrap: true,
      ),
    );
  }

  Widget commentButton = Padding(
    padding: const EdgeInsets.only(right: 30.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        onPressed: () {
          // Implement your onPressed logic here
        },
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF292929),
        shape: CircleBorder(),
        child: const Icon(Icons.comment),
      ),
    ),
  );
}
