import 'package:flutter/material.dart';

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
        )
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 400,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Text(
                        'Ditemukan',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/google.png', // Ganti dengan path gambar Anda
                        width: 100, // Sesuaikan lebar gambar
                        height: 100, // Sesuaikan tinggi gambar
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
