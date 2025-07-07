import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/components/costomLogo.dart';
import 'package:flutterfire/components/customBottom.dart';
import 'package:flutterfire/components/textformfied.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 70,
          ),
          const LogoThem(),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Login to continue using app",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                CoustomText(text: "Enter Your Email", myController: Email),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                CoustomText(
                    text: "Enter Your Password", myController: password),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child:
                      InkWell(onTap: () {}, child: const Text("Forgot Password ?")),
                ),
              ],
            ),
          ),
          CustomBottom(
            title: "Login",
            onPressed: () async {
              try {
                final credential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: Email.text,
                  password: password.text,
                );
                Navigator.of(context).pushReplacementNamed("Home");
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            },
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: const Text("Or Login With",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("غير متوفر حاليا")),
                    );
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "images/fasebook.jpg",
                        height: 50,
                        width: 50,
                      ))),
              InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("غير متوفر حاليا")),
                    );
                  },
                  child: Image.asset(
                    "images/ios.jpg",
                    height: 50,
                    width: 50,
                  )),
              InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("غير متوفر حاليا")),
                    );
                  },
                  child: Image.asset(
                    "images/google.jpg",
                    height: 50,
                    width: 50,
                  )),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't Have An Acount? ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("SingUp");
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange[400]),
                  )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
