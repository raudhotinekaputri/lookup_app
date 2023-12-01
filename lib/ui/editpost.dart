import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookup_app/ui/homecard.dart';

void main() {
  runApp(const EditPosting());
}

class EditPosting extends StatelessWidget {
  const EditPosting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Expanded(
                child: EditPost(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditPost extends StatefulWidget {
  const EditPost({super.key});

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String _status = 'Kehilangan';

  TextEditingController _judulPostController = TextEditingController();
  TextEditingController _deskripsiPostController = TextEditingController();

  Future<void> _getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Lakukan sesuatu dengan gambar yang dipilih, seperti menampilkan di UI
      // image.path berisi path dari gambar yang dipilih
    }
  }

  @override
  void dispose() {
    _judulPostController.dispose();
    _deskripsiPostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 393,
            height: 900,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF292929)),
            child: Stack(children: [
              Positioned(
                left: 40, // Sesuaikan posisi tombol kembali di sini
                top:
                    85, // Sesuaikan posisi tombol kembali di sini, agar sejajar dengan teks 'Create & Posting'
                child: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Colors.white), // Menggunakan ikon panah ke kiri
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeCard()), // Ganti HomePage() dengan halaman yang sesuai
                    );
                  },
                ),
              ),
              Positioned(
                left: 59,
                top: 95,
                child: SizedBox(
                  width: 285,
                  height: 33,
                  child: Text(
                    'Edit Post',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),

              // Positioned(
              // left: 558,
              // top: 50,
              //child: Container(
              // width: 683,
              // height: 455,
              //decoration: BoxDecoration(
              //image: DecorationImage(
              //image:
              //  NetworkImage("https://via.placeholder.com/683x455"),
              //fit: BoxFit.contain,
              // ),
              // ),
              // ),
              //),
              //Positioned(
              //left: 302.66,
              //top: 769,
              //child: Transform(
              //transform: Matrix4.identity()
              //..translate(0.0, 0.0)
              //..rotateZ(0.16),
              //child: Container(
              //width: 43,
              //height: 42.97,
              //decoration: ShapeDecoration(
              //color: Colors.white,
              //shape: OvalBorder(),
              //),
              //),
              //),
              //),
              Stack(
                children: [
                  Positioned(
                    left: 290,
                    top: 810,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Tambahkan logika untuk tombol submit di sini
                        // Misalnya, Anda bisa menambahkan panggilan fungsi untuk menangani proses pengiriman post
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        color: Colors
                            .green, // Sesuaikan warna ikon sesuai keinginan
                      ),
                    ),
                  ),
                  Positioned(
                    left: -4,
                    top: -1,
                    child: Container(
                      width: 411,
                      height: 65,
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 32,
                        right: 41,
                        bottom: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 47,
                    top: 99,
                    child: Container(
                      width: 24,
                      height: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Stack(children: []),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 153,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 294,
                                  height: 56,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _judulPostController,
                                    style: const TextStyle(
                                        color: Colors
                                            .black), // Teks input pengguna
                                    // TextField untuk Judul
                                    decoration: InputDecoration(
                                      hintText: 'Judul',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFA3A3A3),
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: 294,
                                  height: 56,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 18),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      _getImageFromGallery(); // Panggil fungsi untuk mengambil gambar dari galeri
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pilih Gambar Dari Galeri',
                                          style: TextStyle(
                                            color: Color(0xFFA3A3A3),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width:
                                                    60), // Jarak antara ikon dan teks
                                            Icon(
                                              Icons.photo,
                                              color: Color(0xFFA3A3A3),
                                              size: 24,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                    width: 294,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF5F5F5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    color: Color(0xFFA3A3A3),
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio<String>(
                                                value: 'Kehilangan',
                                                groupValue: _status,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _status = value!;
                                                  });
                                                },
                                                visualDensity: VisualDensity(
                                                    horizontal: -4,
                                                    vertical:
                                                        0), // Mengatur posisi lebih ke kiri
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                activeColor: Colors
                                                    .black, // Mengatur warna lingkaran radio button
                                              ),
                                              Text(
                                                'Kehilangan',
                                                style: TextStyle(
                                                  color: Colors
                                                      .black, // Ubah warna teks menjadi hitam
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Radio<String>(
                                                value: 'Ditemukan',
                                                groupValue: _status,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _status = value!;
                                                  });
                                                },
                                                visualDensity: VisualDensity(
                                                    horizontal: 4,
                                                    vertical:
                                                        0), // Mengatur posisi lebih ke kiri
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                activeColor: Colors
                                                    .black, // Mengatur warna lingkaran radio button
                                              ),
                                              Text(
                                                'Ditemukan',
                                                style: TextStyle(
                                                  color: Colors
                                                      .black, // Ubah warna teks menjadi hitam
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ])),
                                const SizedBox(height: 20),
                                Container(
                                  width: 294,
                                  height: 376,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _deskripsiPostController,
                                    style: const TextStyle(
                                        color: Colors
                                            .black), // Teks input pengguna
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        hintText: 'Deskripsi',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFA3A3A3),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ])),
      ],
    );
  }
}
