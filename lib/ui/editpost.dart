import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      home: const Scaffold(
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
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 393,
        height: 852,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF292929)),
        child: Stack(
          children: [
            Positioned(
              left: 40,
              top: 85,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // Tambahkan logika untuk kembali ke halaman sebelumnya di sini
                  // Misalnya, Anda bisa menggunakan Navigator.pop(context) untuk kembali
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
            Positioned(
              left: 290,
              top: 750,
              child: FloatingActionButton(
                onPressed: () {
                  // Tambahkan logika untuk tombol submit di sini
                  // Misalnya, Anda bisa menambahkan panggilan fungsi untuk menangani proses pengiriman post
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
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
              top: 133,
              child: PostDetailsWidget(
                judulPostController: _judulPostController,
                deskripsiPostController: _deskripsiPostController,
                getStatus: _status,
                getImageFromGallery: _getImageFromGallery,
                setStatus: (String value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetailsWidget extends StatelessWidget {
  final TextEditingController judulPostController;
  final TextEditingController deskripsiPostController;
  final String getStatus;
  final Function(String) setStatus;
  final Future<void> Function() getImageFromGallery;

  const PostDetailsWidget({
    Key? key,
    required this.judulPostController,
    required this.deskripsiPostController,
    required this.getStatus,
    required this.setStatus,
    required this.getImageFromGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 294,
            height: 56,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: TextFormField(
              controller: judulPostController,
              style: const TextStyle(color: Colors.black),
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
          SizedBox(height: 20),
          Container(
            width: 294,
            height: 56,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: GestureDetector(
              onTap: getImageFromGallery,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(width: 60),
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
          SizedBox(height: 20),
          Container(
            width: 294,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      groupValue: getStatus,
                      onChanged: (String? value) {
                        setStatus(value!);
                      },
                      visualDensity: VisualDensity(
                        horizontal: 3,
                        vertical: 0,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Colors.black,
                    ),
                    Text(
                      'Kehilangan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Radio<String>(
                      value: 'Ditemukan',
                      groupValue: getStatus,
                      onChanged: (String? value) {
                        setStatus(value!);
                      },
                      visualDensity: VisualDensity(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Colors.black,
                    ),
                    Text(
                      'Ditemukan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 294,
            height: 366,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: TextFormField(
              controller: deskripsiPostController,
              style: const TextStyle(color: Colors.black),
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Deskripsi',
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
        ],
      ),
    );
  }
}
