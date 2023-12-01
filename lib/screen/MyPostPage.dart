import 'package:flutter/material.dart';
import 'package:lookup_app/ui/addpost_niru.dart';
import 'package:lookup_app/ui/addpost_niru_copy.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/mypost.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';
import 'package:lookup_app/widgets/floating_button.dart';

class MyPostPage extends StatelessWidget {
  const MyPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavTop(),
      drawer: Sidebar(),
      bottomNavigationBar: const NavBottom(),
      body: MyPost(),
      floatingActionButton: FloatingButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddPostScreen()),
        );
      }),
    );
  }
}
