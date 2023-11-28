import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Postimage extends StatefulWidget {
  const Postimage({Key? key}) : super(key: key);

  @override
  _PostimageState createState() => _PostimageState();
}

class _PostimageState extends State<Postimage> {
  bool _isLoading = false;
  Uint8List? _image;
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
