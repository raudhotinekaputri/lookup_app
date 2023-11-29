import 'package:flutter/material.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/profilescreen.dart';
import 'package:lookup_app/ui/search_page.dart';

void main() {
  runApp(const NavBottom());
}

class NavBottom extends StatelessWidget {
  const NavBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) => Container(
              height: 59.27,
              decoration: BoxDecoration(
                color: Color(0xFF292929),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, -4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => Profile(uid: '',)), // Ganti HomePage() dengan halaman yang sesuai
                         );
                         },
                         ),

                  IconButton(
                    icon: Icon(Icons.home, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeCard()), // Ganti HomePage() dengan halaman yang sesuai
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchPage()), // Ganti HomePage() dengan halaman yang sesuai
                      );
                    },
                  ),
                ],
              ),
            ));
  }
}
