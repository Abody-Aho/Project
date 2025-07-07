import 'package:flutter/material.dart';

class CoustomText extends StatelessWidget {
  final String text;
  final TextEditingController myController;
  const CoustomText({super.key, required this.text, required this.myController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: text,
          hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(50),
          )),
    );
  }
}
