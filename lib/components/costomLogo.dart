import 'package:flutter/material.dart';

class LogoThem extends StatelessWidget {
  const LogoThem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(100)),
          child: Image.asset(
            "images/6.png",
            height: 90,
            width: 90,
          ),
        ),
      ],
    );
  }
}
