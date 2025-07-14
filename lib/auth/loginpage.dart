import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/components/costomLogo.dart';
import 'package:flutterfire/components/customBottom.dart';
import 'package:flutterfire/components/textformfied.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloaiding = false;
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloaiding ? (Center(child: CircularProgressIndicator(color: Colors.orangeAccent,),)) : ListView(
        children: [
          const SizedBox(height: 70),
          const LogoThem(),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text(
                  "Login to continue using app",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                CoustomText(text: "Enter Your Email", myController: Email),
                const SizedBox(height: 10),
                const Text("Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                CoustomText(text: "Enter Your Password", myController: password),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () async {
                      if (Email.text == "") {
                        Flushbar(
                          title: "خطأ",
                          message: "أدخل البريد الالكتروني اولا",
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.orange,
                          flushbarPosition: FlushbarPosition.BOTTOM,
                        )..show(context);
                      } else {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: Email.text);
                          Flushbar(
                            title: "خطأ",
                            message: "تم ارسال يرجاء التاكد من حسابك",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.orange,
                            flushbarPosition: FlushbarPosition.BOTTOM,
                          )..show(context);
                        } catch (e) {
                          print(e);
                          Flushbar(
                            title: "خطأ",
                            message: "الحساب غير موجود اعد كتابتة بشكل صحيح واعد المحاوله",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.orange,
                            flushbarPosition: FlushbarPosition.BOTTOM,
                          )..show(context);
                        }
                      }
                    },
                    child: const Text("Forgot Password ?"),
                  ),
                ),
              ],
            ),
          ),
          CustomBottom(
            title: "Login",
            onPressed: () async {
              if (Email.text.isEmpty || password.text.isEmpty) {
                Flushbar(
                  title: "خطأ",
                  message: "يجب ملأ جميع الحقول",
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.orange,
                  flushbarPosition: FlushbarPosition.BOTTOM,
                )..show(context);
                return; // مهم جدًا
              }

              setState(() {
                isloaiding = true;
              });

              try {
                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: Email.text,
                  password: password.text,
                );

                if (credential.user!.emailVerified) {
                  Navigator.of(context).pushReplacementNamed("Home");
                } else {
                  Flushbar(
                    title: "خطأ",
                    message: "أذهب الى بريدك للتحقق حتى يتم تفعيل حسابك",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);
                }
              } on FirebaseAuthException catch (e) {
                setState(() {
                  isloaiding = false;
                });
                if (e.code == 'user-not-found') {
                  Flushbar(
                    title: "خطأ",
                    message: 'لا يوجد مستخدم بهذا البريد.',
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);
                } else if (e.code == 'wrong-password') {
                  Flushbar(
                    title: "خطأ",
                    message: "كلمة المرور غير صحيحة.",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);
                } else {
                  Flushbar(
                    title: "خطأ",
                    message: "حدث خطأ غير متوقع: ${e.code}",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);
                }
              }

              setState(() {
                isloaiding = false;
              });
            },
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: const Text("Or Login With",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
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
                  child: Image.asset("images/fasebook.jpg", height: 50, width: 50),
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("غير متوفر حاليا")),
                  );
                },
                child: Image.asset("images/ios.jpg", height: 50, width: 50),
              ),
              InkWell(
                onTap: () {
                  signInWithGoogle();
                },
                child: Image.asset("images/google.jpg", height: 50, width: 50),
              ),
            ],
          ),
          const SizedBox(height: 30),
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
                      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange[400]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
