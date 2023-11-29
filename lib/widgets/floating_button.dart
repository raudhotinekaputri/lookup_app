import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;

  FloatingButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onPressed();
      },
      tooltip: 'Create Post',
      child: const Icon(Icons.create, color: Colors.black),
    );
  }
}
