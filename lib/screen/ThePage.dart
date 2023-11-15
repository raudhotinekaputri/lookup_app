import 'package:flutter/material.dart';
import 'package:lookup_app/ui/homecard.dart';
import 'package:lookup_app/ui/navbottom.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';

class ThePage extends StatelessWidget {
  const ThePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavTop(),
      drawer: Sidebar(),
      bottomNavigationBar: const NavBottom(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CardContainer(jenis:"ditemukan", judul:"lorem", akun:"@syifa", status:"belom selesai",),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
