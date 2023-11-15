import 'package:flutter/material.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/sidebar.dart';

class HomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 96),
            Expanded(
              child: ListView.builder(
                itemCount: 2, 
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CardContainer(),
                  );
                },
              ),
            )
          ],
        )),
      // body: SafeArea(
      //   child: Column(children: [
      //     SizedBox(height: 96),
      //     Padding(padding:EdgeInsets.symmetric(vertical: 10), child:CardContainer() ,),
      //     SizedBox(height: 16.0),
      //       CardContainer(),
      //   ],)
      // ),
    );
  }
}

class CardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: EdgeInsets.all(16), 
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 300,
        height: 400,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          border: Border.all(color: Colors.white),
        ),
        child: // Tambahkan konten di sini
          Center(
            child: Text(
              "Card Content",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
      ),
      ),)
    );
  }
}
