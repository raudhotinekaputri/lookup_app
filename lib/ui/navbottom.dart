import 'package:flutter/material.dart';

void main() {
  runApp(const NavBottom());
}

class NavBottom extends StatelessWidget {
  const NavBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        bottomNavigationBar: Container(
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
                  // Action for home button
                },
              ),
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  // Action for search button
                },
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Action for profile button
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
