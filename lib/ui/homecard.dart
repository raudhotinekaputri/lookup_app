import 'package:flutter/material.dart';
import 'package:lookup_app/ui/navtop.dart';
import 'package:lookup_app/ui/see_more.dart';
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
                    child: CardContainer(jenis: 'ditemukan', judul: "lorem", akun: '@syifa', status: 'belum ditemukan', gambar: 'https://asset.kompas.com/crops/CLjiHFPPa5GJihSrpTWbwNni99M=/167x0:1067x600/750x500/data/photo/2022/06/29/62bba4c09354f.png'),
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
  final String jenis;
  final String judul;
  final String akun;
  final String status;
  final String gambar;

  CardContainer({
    Key? key,
    required this.jenis,
    required this.judul,
    required this.akun,
    required this.status,
    required this.gambar,
  }) : super(key: key);

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
                        jenis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Center(
                      child: Image.network(
                        gambar, // Ganti dengan path gambar Anda
                        width: 100, // Sesuaikan lebar gambar
                        height: 100, // Sesuaikan tinggi gambar
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      akun,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Lakukan sesuatu saat tombol ditekan
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => SeeMorePage()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF8C92B6), // Ganti warna latar belakang sesuai keinginan Anda
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text('Lihat'),
                        ),
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