import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/components/costomLogo.dart';
import 'package:flutterfire/components/customBottom.dart';
import 'package:flutterfire/components/textformfied.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController Conformpassword = TextEditingController();
  String phoneNumber = "";

  awsome(Title,Desc){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: Title,
        desc: Desc,
        btnCancelOnPress: () {},
    btnOkOnPress: () {},
    ).show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          const LogoThem(),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SingUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "SingUp to continue using app",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Username",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                CoustomText(
                    text: "Enter Your Username", myController: username),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      labelText: 'Enter your phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    initialCountryCode: 'YE',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber;
                    },
                  ),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Conform Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                CoustomText(
                    text: "Conform Your Password",
                    myController: Conformpassword),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomBottom(
            title: "Singup",
            onPressed: () async {
              if (password.text != Conformpassword.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("كلمة المرور غير متطابقة")),
                );
                return;
              }

              try {
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: Email.text.trim(),
                  password: password.text.trim(),
                );
                await credential.user!.updateDisplayName(username.text.trim());
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(credential.user!.uid)
                    .set({
                  'name': username.text.trim(),
                  'email': Email.text.trim(),
                  'phone': phoneNumber,
                });

                var user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await user.sendEmailVerification();
                  Flushbar(
                    title: "تم إرسال التحقق",
                    message: "تم إرسال رابط التحقق إلى: ${user.email}",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context).then((_) {
                    Navigator.of(context).pushReplacementNamed("Login");
                  });
                } else {
                  Flushbar(
                    title: "خطأ",
                    message: "لم يتم تسجيل الدخول",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);
                }

              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  Flushbar(
                    title: "خطأ",
                    message:'كلمة المرور ضعيفة جدًا',
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);

                } else if (e.code == 'email-already-in-use') {
                  Flushbar(
                    title: "خطأ",
                    message: 'هذا البريد مستخدم مسبقًا',
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);
                } else {
                  Flushbar(
                    title: "خطأ",
                    message: 'أملاء الحقول الفارغة',
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orangeAccent,
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  )..show(context);

                  print("${e.message}");
                }
              } catch (e) {
                print(e);
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Have An Acount? ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("Login");
                  },
                  child: Text(
                    "Login",
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
