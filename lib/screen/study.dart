import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<QueryDocumentSnapshot> data = [];

  awsome(Title,Desc,DialogType,Cancel,Ok){
    AwesomeDialog(
      context: context,
      dialogType: DialogType,
      animType: AnimType.rightSlide,
      title: Title,
      desc: Desc,
      btnCancelOnPress: Cancel,
      btnOkOnPress: Ok,
    ).show();
  }

  getData() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("StudyLisen").get();
    data.addAll(querySnapshot.docs);
    setState(() {

    });
  }
  @override
  void initState() {
    getData();
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدروس"),
        centerTitle: true,
      ),
      floatingActionButton: (user != null && user!.email == allowedEmail)
          ? FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).pushNamed("Add");
        },
        child: const Icon(Icons.add),
      )
          : null,
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.orange,))
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return InkWell(
            onLongPress: (){
              (user != null && user!.email == allowedEmail) ? awsome("تحذير", "هل انت متاكد من عملية الحذف",DialogType.warning,() {},() async{
                await FirebaseFirestore.instance.collection("StudyLisen").doc(data[i].id).delete();
                Navigator.of(context).pushReplacementNamed("Home");
              }) : null;
            },
            child: Card(
              child: ListTile(
                title: Text("أسم الدرس : ${data[i]["name"]}"),
              ),
            ),
          );
        },
      ),

    );
  }
}
