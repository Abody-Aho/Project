import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'package:flutterfire/addthings/addpage.dart';
=======
>>>>>>> origin/main
import 'package:flutterfire/auth/loginPage.dart';
import 'package:flutterfire/auth/singUpPage.dart';
import 'package:flutterfire/screen/home_page.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage2();
  }
}

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('===============User is currently signed out!');
      } else {
        print('===============User is signed in!');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.orange[400],
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontFamily: "Rakkas",
                  fontSize: 28,
                  color: Colors.black)
          )
      ),
      home: Scaffold(
<<<<<<< HEAD
          body: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ?  const HomePage() : const LoginPage() ,
=======
          body: FirebaseAuth.instance.currentUser == null ? LoginPage() : HomePage()
>>>>>>> origin/main
      ),
      routes: {
        "SingUp": (context) => SingUp(),
        "Login": (context) => LoginPage(),
<<<<<<< HEAD
        "Home": (context) => HomePage(),
        "Add": (context) => AddPage(),
=======
        "Home": (context) => HomePage()
>>>>>>> origin/main
      },
    );
  }
}
