import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Settings1 extends StatelessWidget {
  const Settings1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الضبط"),
        centerTitle: true,
      ),
      body: Center(
        child: ListTile(
          onTap: () async {

            GoogleSignIn googleSignIn = GoogleSignIn();
            googleSignIn.disconnect();
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil("Login", (route) => false);
          },
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Out",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(Icons.exit_to_app),
            ],
          ),
        ),
      )

    );
  }
}
