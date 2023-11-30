import 'package:flutter/material.dart';

class HelpDesk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF888FB4), Color(0xFF5C6FA7)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Bagaimana kami bisa membantu Anda?',
                    style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 4),
                Center(
                  child: Text(
                    'Hubungi kami di nomor: +XX XXX XXXX',
                    style: TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          buildQuestionAndAnswer(
            question: 'Apa langkah-langkah untuk mengganti password?',
            answer: 'Anda dapat mengganti password Anda dengan masuk ke pengaturan akun dan pilih opsi "Ganti Password".',
          ),
          buildQuestionAndAnswer(
            question: 'Bagaimana cara menghubungi layanan pelanggan?',
            answer: 'Anda dapat menghubungi layanan pelanggan kami di nomor +XX XXX XXXX atau melalui email support@example.com.',
          ),
        ],
      ),
    );
  }

  Widget buildQuestionAndAnswer({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $question',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'A: $answer',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

