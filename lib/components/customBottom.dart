import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CustomBottom({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(50)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            "$title",
            style: const TextStyle(color: Colors.white, fontSize: 19),
          ),
        )
    );
  }
}
