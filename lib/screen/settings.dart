import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:google_sign_in/google_sign_in.dart';
=======
>>>>>>> origin/main

class Settings extends StatelessWidget {
  const Settings({super.key});

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
<<<<<<< HEAD
            GoogleSignIn googleSignIn = GoogleSignIn();
            googleSignIn.disconnect();
=======
>>>>>>> origin/main
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
