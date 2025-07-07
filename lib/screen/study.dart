import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Study extends StatefulWidget {
  const Study({super.key});

  @override
  State<Study> createState() => _StudyState();
}

class _StudyState extends State<Study> {
  User? user;
  final String allowedEmail = 'abdalwalysamer6@gmail.com';
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (user != null && user!.email == allowedEmail)
          ? FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: (){
          Navigator.of(context).pushNamed("Add");
        },
        child: Icon(Icons.add),
      ) : null ,
     appBar: AppBar(title: Text("الدروس"),centerTitle: true,),
      body: Center(child: Text("Study here",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
    );
  }
}
