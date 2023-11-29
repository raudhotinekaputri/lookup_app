import 'package:flutter/material.dart';
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

  get uid => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavTop(),
      drawer: Sidebar(
        uid: null,
      ),
      bottomNavigationBar: const NavBottom(),
      body: Container(
        color: const Color(0xFF212121),
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
                  child: const Text(
                    'Dicari HP hilang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
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
  }

  Widget imageSection = Container(
    padding: const EdgeInsets.all(16),
    child: Image.network(
      'https://cdn1.katadata.co.id/media/images/temp/2023/01/05/GUNUNG_UNTUK_PEMULA-2023_01_05-17_39_26_3e89d633fc2e7715235860e7f62db958.png',
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    ),
  );

  Widget profileSection = Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://example.com/path/to/your/profile/image.jpg',
              ),
              radius: 15,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Syifa Hadju',
                  style: TextStyle(
                    fontSize: 18,
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
                  color: value == 'Sudah Selesai' ? Colors.white : Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );

  final Widget textSection = Container(
    padding: const EdgeInsets.all(16),
    child: const Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
      'Alps. Situated 1,578 meters above sea level, it is one of the '
      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
      'half-hour walk through pastures and pine forest, leads you to the '
      'lake, which warms to 20 degrees Celsius in the summer. Activities '
      'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );

  final Widget commentButton = Padding(
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
