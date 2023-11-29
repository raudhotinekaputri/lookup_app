import 'package:flutter/material.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/sidebar.dart';

class NavTop extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) => AppBar(
              backgroundColor: Color(0xFF292929),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 22.0, top: 17.0),
                  child: Text(
                    'LookUp!',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 19,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ));
  }
}
