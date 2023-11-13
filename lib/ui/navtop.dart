import 'package:flutter/material.dart';

void main() {
  runApp(const NavTop());
}

class NavTop extends StatelessWidget {
  const NavTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 22.0, top: 17.0),
                child: Text(
                  'LookUp!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: ListView(
          children: [
            Frame52(),
          ],
        ),
      ),
    );
  }
}

class Frame52 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF292929)),
          child: Stack(
            children: [],
          ),
        ),
      ],
    );
  }
}
